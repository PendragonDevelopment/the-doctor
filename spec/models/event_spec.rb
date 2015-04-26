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

  describe "Tardis methods" do

    # Generate a token first before running these tests.  There is a spec that makes sure that this isn't nil -
    # and if it doesn't work right then none of the other tests will work anyway

    VCR.use_cassette("generate_token") do
      Event.generate_token
    end

    describe "responds to its methods" do
      subject {event}

      it {is_expected.to respond_to(:get_schedule_blocks)}
      it {is_expected.to respond_to(:get_schedule_block)}
      it {is_expected.to respond_to(:get_appointments_on_schedule_block)}
      it {is_expected.to respond_to(:get_appointment_on_schedule_block)}
      it {is_expected.to respond_to(:create_schedule_block)}
      it {is_expected.to respond_to(:update_schedule_block)}
      it {is_expected.to respond_to(:delete_schedule_block)}
      it {is_expected.to respond_to(:token)}

      it "@@token is not nil" do
        expect(event.token).not_to be_nil
      end

    end

    describe "ScheduleBlock methods" do

      describe "#get_schedule_blocks" do

        before (:each) do
          VCR.use_cassette("get_schedule_blocks") do
            @schedule_blocks = event.get_schedule_blocks
          end
        end

        it "gets all the schedule_blocks" do
          #need to figure out a way to test that the response is a hash or a JSON object
          expect(@schedule_blocks).not_to be_nil
        end

      end

      describe "#get_schedule_block" do

        let(:schedule_block_id) { 1 }

        before(:each) do
          VCR.use_cassette("get_schedule_block") do
            @schedule_block = event.get_schedule_block(schedule_block_id)
          end
        end

        it "does not raise an error" do
          expect(@schedule_block).not_to be_nil
        end

        it "returns the requested schedule_block" do
          expect(@schedule_block["id"]).to eq(schedule_block_id)
        end
      end

      describe "#get_appointments_on_schedule_block" do

        let(:schedule_block_id) { 1 }

        before(:each) do
          VCR.use_cassette("get_appointments_on_schedule_block") do
            @appointments = event.get_appointments_on_schedule_block(schedule_block_id)
          end
        end

        #this needs to be better
        it "returns the appointments on the requested schedule_block" do
          expect(@appointments).not_to be_nil
        end
      end

      describe "#get_appointment_on_schedule_block" do
        let(:schedule_block_id) { 1 }
        let(:appointment_id) { 1 }

        before(:each) do
          VCR.use_cassette("get_appointment_on_schedule_block") do
            @appointment = event.get_appointment_on_schedule_block(schedule_block_id, appointment_id)
          end
        end

        it "returns the requested appointment" do
          expect(@appointment["id"]).to eq(appointment_id)
        end
      end

      describe "#create_schedule_block" do

        let(:schedule_block_params) do
          {
            :start_time => DateTime.now,
            :end_time => DateTime.now + 1,
            :reservation_min => 2,
            :reservation_max => 10,
            :status => "open",
            :host_id => host.id,
            :event_id => event.id,
            :location_id => event.location_id
          }
        end

        before(:each) do
          VCR.use_cassette("create_schedule_block") do
            @response = event.create_schedule_block(schedule_block_params)
          end
        end

        it "creates a new schedule block" do
          # this is currently returning an error, I believe because the tardis is expecting a user_id.
          # which it shouldn't
          expect(@response.status).to eq 201
        end

      end

      describe "#update_schedule_block" do

        let(:schedule_block_id) { 1 }

        let(:updated_schedule_block_params) do
          {
            :start_time => DateTime.now + 1,
            :end_time => DateTime.now + 3,
            :reservation_min => 2,
            :reservation_max => 10,
            :status => "open",
            :host_id => host.id,
            :event_id => event.id,
            :location_id => event.location_id
          }
        end

        before(:each) do
          VCR.use_cassette("update_schedule_block") do
            @response = event.update_schedule_block(schedule_block_id, updated_schedule_block_params)
          end
        end

        it "updates the schedule_block" do
          expect(@response.status).to eq 200
        end
      end

      describe "#delete_schedule_block" do

        before(:each) do
          VCR.use_cassette("delete_schedule_block") do
            #not quite sure how to do this without deleting blocks on the tardis.
            #This is probably going to require mocks and stubs to be done well
          end
        end

        it "deletes the schedule block" do
          pending "Should figure out how to do this"
        end
      end
    end

    describe "Appointment methods" do

      describe "#get_appointments" do

        before(:each) do
          VCR.use_cassette("get_appointments") do
            @response = event.get_appointments
          end
        end

        it "retrieves all the appointments" do
          expect(@response).not_to be_nil
        end
      end

      describe "#update_appointment" do
        let(:user) {create(:user)}
        let(:appointment) { 1 }

        let(:updated_appointment_params) do
          {
            :schedule_block_id => 1,
            :attendee => user.id,
            :status => "in_progress"
          }
        end

        before(:each) do
          VCR.use_cassette("update_appointment") do
            @response = event.update_appointment(appointment, updated_appointment_params)
          end
        end

        it "updates the appointment" do
          expect(@response.status).to eq 200
        end
      end

      describe "#delete_appointment" do

        before(:each) do
          VCR.use_cassette("delete_appointment") do
            #again, not sure how to work this well
          end
        end

        it "deletes the appointment" do
          pending "Need to do mocks and stubs here"
        end
      end

    end

  end


end
