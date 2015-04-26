# == Schema Information
#
# Table name: hosts
#
#  id             :integer          not null, primary key
#  rating         :integer
#  active         :boolean
#  bio            :string
#  user_id        :integer
#  birthdate      :date
#  status         :integer
#  resume         :string
#  direct_deposit :string
#  voided_check   :string
#  w9             :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

require 'rails_helper'

RSpec.describe Host, type: :model do
  let(:user) {FactoryGirl.create(:user)}
  let(:host) {user.host = FactoryGirl.create(:host)}

  describe "Model attributes set up" do
  	subject {host}

  	it {is_expected.to respond_to(:id)}
  	it {is_expected.to respond_to(:rating)}
  	it {is_expected.to respond_to(:active)}
  	it {is_expected.to respond_to(:bio)}
  	it {is_expected.to respond_to(:user_id)}
  	it {is_expected.to respond_to(:birthdate)}
  	it {is_expected.to respond_to(:status)}
  	it {is_expected.to respond_to(:resume)}
  	it {is_expected.to respond_to(:direct_deposit)}
  	it {is_expected.to respond_to(:voided_check)}
  	it {is_expected.to respond_to(:w9)}
  	it {is_expected.to respond_to(:created_at)}
  	it {is_expected.to respond_to(:updated_at)}

  	it {is_expected.to be_valid}

    it "active defaults to false" do
      #my guess is that we are going to also need a db migration to ensure this default
      expect(host.active).to eq(false)
    end
  end

  describe "Attribute validations" do

    context "presence validations" do
      let(:other_user) {create(:user)}
      let(:invalid_host) {other_user.host = create(:invalid_host)}

      
      #why would this be a validation?
      #it "is invalid without a rating" do
      #  expect(invalid_host).not_to be_valid
      #end
    end

    context "format validations" do

      it "#bio returns a string" do
        expect(host.bio).to be_a(String)
      end

      it "#resume returns a string" do
        expect(host.resume).to be_a(String)
      end

      it "#direct_deposit returns a string" do
        expect(host.direct_deposit).to be_a(String)
      end

      it "#voided_check returns a string" do
        expect(host.voided_check).to be_a(String)
      end

      it "#w9 returns a string" do
        expect(host.w9).to be_a(String)
      end

      it "#birthdate returns a date" do
        expect(host.birthdate).to be_a(Date)
      end
    end
  end

end
