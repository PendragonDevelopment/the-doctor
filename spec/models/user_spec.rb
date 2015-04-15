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

	describe "Attribute Formatting" do
	  it "#email returns a string" do
	    expect(user.email).to match 'test@example.com'
	  end
	end

end
