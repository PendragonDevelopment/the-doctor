# == Schema Information
#
# Table name: activities
#
#  id         :integer          not null, primary key
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Activity, type: :model do
  let(:activity) {FactoryGirl.create(:activity)}

  describe "Model attributes set up" do
  	subject {activity}

  	it {is_expected.to respond_to(:id)}
  	it {is_expected.to respond_to(:title)}

  	it {is_expected.to be_valid}
  end

  describe "Activity validations" do
  	
    it "is valid with a title" do
      act = Activity.new(title: "New activity")
      expect(act).to be_valid
    end

    it "is invalid without a title" do
      expect(FactoryGirl.build(:activity, title: nil)).not_to be_valid
    end
  end
end
