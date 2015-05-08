require 'rails_helper'

Rspec.describe AppointmentService do

  let(:appt_service) {AppointmentService.new}

  describe "#get_appointments" do

        before(:each) do
          VCR.use_cassette("get_appointments") do
            @response = appt_service.get_appointments
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
            @response = appt_service.update_appointment(appointment, updated_appointment_params)
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