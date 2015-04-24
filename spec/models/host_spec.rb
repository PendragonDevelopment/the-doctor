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
  let(:host) {FactoryGirl.create(:host)}

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
  end
end
