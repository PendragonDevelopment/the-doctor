class AppointmentService

  attr_reader :token

  def initialize(params)
    @token = params[:token]
  end

  def get_appointments
    JSON.parse(token.get('/api/v1/appointments').body)
  end

  def update_appointment(appointment_id, appointment_params)
    token.put("/api/v1/appointments/#{appointment_id}", appointment_params)
  end

  def delete_appointment(appointment_id)
    token.delete("/api/v1/appointments/#{appointment_id}")
  end
end