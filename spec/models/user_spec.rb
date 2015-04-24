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

require 'rails_helper'
require 'stripe_mock'

describe User do

  let(:user) {FactoryGirl.create(:user)}

  describe "Model attributes set up" do
  	subject { user }

  	it {is_expected.to respond_to(:first_name) }
    it {is_expected.to respond_to(:last_name) }
    it {is_expected.to respond_to(:role) }
    it {is_expected.to respond_to(:username) }
    it {is_expected.to respond_to(:email) }
    it {is_expected.to respond_to(:stripe_customer_id) }
    it {is_expected.to respond_to(:host_id) }

  	it {is_expected.to be_valid}
  end

  describe "User validations" do
    it "is invalid without a username" do
      expect(FactoryGirl.build(:user, username: nil)).not_to be_valid
    end

    it "is invalid without an email" do
      expect(FactoryGirl.build(:user, email: nil)).not_to be_valid
    end

    it "requires a unique email" do
      user1=FactoryGirl.create(:user)
      user2=user1.dup

      expect(user2).not_to be_valid
    end

  end

	describe "Attribute Formatting" do
	  it "#email returns a string" do
	    expect(user.email).to be_a(String)
	  end

    it "#username returns a string" do
      expect(user.username).to be_a(String)
    end

    it "#role defaults to user" do
      expect(user.role).to eq("user")
    end
	end

  describe "Stripe Methods" do

    let(:stripe_helper) { StripeMock.create_test_helper }
    before { StripeMock.start }
    after { StripeMock.stop }

    let(:card_params) { {email: user.email, number: "4242424242424242", credit_card_expiry_month: "10", credit_card_expiry_year: "16", cvv: "123"} }

    describe "create_stripe_customer" do

      it "creates the stripe customer" do
        user.create_stripe_customer( {email: user.email}, user.create_stripe_token(card_params) )
        expect(user.stripe_customer_id).not_to eq(nil)
      end

    end

    describe "get_customer_from_stripe" do

      let (:customer) { user.create_stripe_customer( {email: user.email}, user.create_stripe_token(card_params) ); user.get_customer_from_stripe }

      it "returns the stripe customer" do
        expect(customer.id).to eq(user.stripe_customer_id)
      end

    end

    describe "create_stripe_token" do

      let (:token) { user.create_stripe_token(card_params) }

      it "creates a valid token" do
        expect(token).not_to eq(nil)
      end

    end

    describe "charge_stripe" do

      let (:charge) { user.charge_stripe(199, card_params) }

      it "creates the charge" do
        expect(charge.amount).to eq(199)
      end

    end
    
  end

end
