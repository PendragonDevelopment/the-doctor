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
#

require 'rails_helper'

RSpec.describe Transaction, type: :model do

  let(:transaction) {FactoryGirl.create(:transaction)}

  describe "Model attributes set up" do
  	subject {transaction}

  	it {is_expected.to respond_to(:id)}
  	it {is_expected.to respond_to(:title)}
  	it {is_expected.to respond_to(:payment_amount)}
  	it {is_expected.to respond_to(:payment_date)}
  	it {is_expected.to respond_to(:status)}
  	it {is_expected.to respond_to(:transaction_record)}
  	it {is_expected.to respond_to(:user_id)}
  	it {is_expected.to respond_to(:created_at)}
  	it {is_expected.to respond_to(:updated_at)}
  	it {is_expected.to respond_to(:appointment_id)}

  	it {is_expected.to be_valid}
  end

  describe "Transaction Validations" do
    it "is invalid without a title" do
      expect(FactoryGirl.build(:transaction, title: nil)).not_to be_valid
    end

    it "is invalid without a payment_amount" do
      expect(FactoryGirl.build(:transaction, payment_amount: nil)).not_to be_valid
    end

    it "is invalid without a payment date" do
      expect(FactoryGirl.build(:transaction, payment_date: nil)).not_to be_valid
    end

  end
end
