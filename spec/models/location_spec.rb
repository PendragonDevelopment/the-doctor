# == Schema Information
#
# Table name: locations
#
#  id          :integer          not null, primary key
#  title       :string
#  description :text
#  latitude    :string
#  longitude   :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'rails_helper'

RSpec.describe Location, type: :model do
  let(:location) {FactoryGirl.create(:location)}

  describe "Model attributes set up" do
  	subject {location}

  	it {is_expected.to respond_to(:id)}
  	it {is_expected.to respond_to(:title)}
  	it {is_expected.to respond_to(:description)}
  	it {is_expected.to respond_to(:latitude)}
  	it {is_expected.to respond_to(:longitude)}

  	it {is_expected.to be_valid}
  end

  describe "Location validations" do
  	
    it "is valid with a title" do
      location = Location.new(title: "New Event")
      expect(location).to be_valid
    end

    it "is invalid without a title" do
      expect(FactoryGirl.build(:invalid_location)).not_to be_valid
    end
  end
end
