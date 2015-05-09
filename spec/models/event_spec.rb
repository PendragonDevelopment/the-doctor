# == Schema Information
#
# Table name: events
#
#  id          :integer          not null, primary key
#  activity_id :integer
#  host_id     :integer
#  location_id :integer
#  event_rate  :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'rails_helper'

RSpec.describe Event, type: :model do

  let!(:host) {create(:host)}
  let!(:location) {create(:location)}
  let!(:activity) {create(:activity)}
  let!(:event) {
    host.events.create(FactoryGirl.attributes_for(:event, :location_id => location.id, :activity_id => activity.id))
  }

  describe "Model attributes set up" do
  	subject {event}

  	it {is_expected.to respond_to(:id)}
    it {is_expected.to respond_to(:activity_id)}
    it {is_expected.to respond_to(:host_id)}
    it {is_expected.to respond_to(:location_id)}
  	it {is_expected.to respond_to(:rate)}

  	it {is_expected.to be_valid}
  end

  describe "Event validations" do
  	it "is invalid without a rate" do
      invalid_event = host.events.build(FactoryGirl.attributes_for(:invalid_event))
      expect(invalid_event).not_to be_valid
    end
  end
end
