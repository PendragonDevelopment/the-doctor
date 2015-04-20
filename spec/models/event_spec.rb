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
  	it {is_expected.to respond_to(:rate)}

  	it {is_expected.to be_valid}
  end

  describe "Event validations" do
  	it "is invalid without a rate" do
      event = FactoryGirl.build(:invalid_event)
      expect(event).not_to be_valid
    end
  end

  describe "Tardis methods" do
    context "responds to its methods" do
      subject {event}

      it {is_expected.to respond_to(:get_schedule_blocks)}
      it {is_expected.to respond_to(:get_schedule_block)}
      it {is_expected.to respond_to(:get_appointments_on_schedule_block)}
      it {is_expected.to respond_to(:get_appointment_on_schedule_block)}
      it {is_expected.to respond_to(:create_schedule_block)}
      it {is_expected.to respond_to(:update_schedule_block)}
      it {is_expected.to respond_to(:delete_schedule_block)}
      it {is_expected.to respond_to(:token_check)}
    end

    context "schedule_block methods" do
      
    end

    context "appointment methods" do
    end

  end

  
end
