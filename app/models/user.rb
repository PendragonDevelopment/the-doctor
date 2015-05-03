# == Schema Information
#
# Table name: users
#
#  id                       :integer          not null, primary key
#  email                    :string           default(""), not null
#  encrypted_password       :string           default(""), not null
#  reset_password_token     :string
#  reset_password_sent_at   :datetime
#  remember_created_at      :datetime
#  sign_in_count            :integer          default(0), not null
#  current_sign_in_at       :datetime
#  last_sign_in_at          :datetime
#  current_sign_in_ip       :inet
#  last_sign_in_ip          :inet
#  created_at               :datetime
#  updated_at               :datetime
#  first_name               :string
#  role                     :integer
#  last_name                :string
#  username                 :string
#  stripe_customer_id       :string
#  host_id                  :integer
#  profile_pic_file_name    :string
#  profile_pic_content_type :string
#  profile_pic_file_size    :integer
#  profile_pic_updated_at   :datetime
#

class User < ActiveRecord::Base
  enum role: [:user, :vip, :admin]
  after_initialize :set_default_role, :if => :new_record?
  has_attached_file :profile_pic, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :profile_pic, :content_type => /\Aimage\/.*\Z/

  validates :username, presence: true
  
  def set_default_role
    self.role ||= :user
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :transactions
  has_one :host
  


  #Stripe methods
  def get_customer_from_stripe
    # Add customer id to User model
    cus_id = self.stripe_customer_id
    customer = Stripe::Customer.retrieve(cus_id)
    return customer
  end

  def create_stripe_customer(params, token)
    puts params[:stripeToken]
    customer = Stripe::Customer.create(
      description: "The Doctor's Companion",
      email: params[:email],
      card: token.id
    )
    self.update_attributes(stripe_customer_id: customer.id)
  end

  def charge_stripe(amount, params)
    token = self.create_stripe_token(params)

    unless self.stripe_customer_id
      self.create_stripe_customer(params, token)
    end

    charge = Stripe::Charge.create(
      customer: self.stripe_customer_id,
      amount: amount,
      description: "The Doctor's Fee",
      currency: 'usd'
    )
    return charge
  end

  def create_stripe_token(params)
    token = Stripe::Token.create(
      card: {
        number: params[:number],
        exp_month: params[:credit_card_expiry_month],
        exp_year: params[:credit_card_expiry_year],
        cvc: params[:cvc]
      }
    )
    return token
  end
end
