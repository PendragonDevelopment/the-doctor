# == Schema Information
#
# Table name: transactions
#
#  id                 :integer          not null, primary key
#  title              :string
#  payment_amount     :integer
#  payment_date       :date
#  status             :integer
#  transaction_record :string
#  user_id            :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  appointment_id     :integer
#  event_id           :integer
#

class Transaction < ActiveRecord::Base
  belongs_to :user
  belongs_to :host_event
  enum status: [:payment_pending, :paid]

=begin
  def get_customer_from_stripe
    # Add customer id to User model
    cus_id = self.customer_id
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
    self.update_attributes(customer_id: customer.id)
  end

  def charge_stripe(amount, params)
    token = self.create_stripe_token(params)

    unless self.customer_id
      self.create_stripe_customer(params, token)
    end

    charge = Stripe::Charge.create(
      customer: self.customer_id,
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
        exp_month: exp_month_year_to_month(params[:credit_card_expiry]),
        exp_year: exp_month_year_to_year(params[:credit_card_expiry]),
        cvc: params[:cvc]
      }
    )
    return token
  end
=end
end

