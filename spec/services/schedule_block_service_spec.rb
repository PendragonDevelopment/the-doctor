require 'rails_helper'

Rspec.describe ScheduleBlockService do

  let(:sb_service) {ScheduleBlockService.new}

  describe "ScheduleBlock methods" do

    describe "#get_schedule_blocks" do

      before (:each) do
        VCR.use_cassette("get_schedule_blocks") do
          @schedule_blocks = sb_service.get_schedule_blocks
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
            @schedule_block = sb_service.get_schedule_block(schedule_block_id)
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
            @appointments = sb_service.get_appointments_on_schedule_block(schedule_block_id)
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
            @appointment = sb_service.get_appointment_on_schedule_block(schedule_block_id, appointment_id)
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
            @response = sb_service.create_schedule_block(schedule_block_params)
          end
        end

        it "creates a new schedule block" do
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
            @response = sb_service.update_schedule_block(schedule_block_id, updated_schedule_block_params)
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
end