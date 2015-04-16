# == Schema Information
#
# Table name: events
#
#  id          :integer          not null, primary key
#  activity_id :integer
#  host_id     :integer
#  location_id :integer
#  rate        :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'rails_helper'

RSpec.describe Event, type: :model do
  let(:event) {FactoryGirl.create(:event)}

  describe "Model attributes set up" do
  	subject {event}

  	it {is_expected.to respond_to(:id)}
  	it {is_expected.to respond_to(:title)}

  	it {is_expected.to be_valid}
  end

  describe "Event validations" do
  	
    it "is valid with a title" do
      event = Event.new(title: "New Event")
      expect(event).to be_valid
    end

    it "is invalid without a title" do
      expect(FactoryGirl.build(:event, title: nil)).not_to be_valid
    end
  end
end
