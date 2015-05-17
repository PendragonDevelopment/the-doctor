class AppointmentService < TardisService

  def get_appointments
    JSON.parse(token.get('/api/v1/appointments').body)
  end

  def get_appointment(schedule_block_id, appointment_id)
    JSON.parse(token.get("/api/v1/schedule_blocks/#{schedule_block_id}/appointments/#{appointment_id}").body)
  end

  def get_attendees_appointments(attendee_id)
    JSON.parse(token.get("/api/v1/appointments/#{attendee_id}").body)
  end

  def create_appointment(schedule_block_id, appointment_params)
    token.post("/api/v1/schedule_blocks/#{schedule_block_id}/appointments", wrap_params(appointment_params))
  end

  def update_appointment(appointment_id, appointment_params)
    token.put("/api/v1/appointments/#{appointment_id}", wrap_params(appointment_params))
  end

  def delete_appointment(appointment_id)
    token.delete("/api/v1/appointments/#{appointment_id}")
  end
end