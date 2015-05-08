class ScheduleBlockService

  attr_reader :token

  def initialize(params)
    @token = params[:token]
  end

  def get_schedule_blocks
    JSON.parse(token.get('/api/v1/schedule_blocks').body)
  end

  def get_schedule_block(schedule_block_id)
    JSON.parse(token.get("/api/v1/schedule_blocks/#{schedule_block_id}").body)
  end

  def get_appointments_on_schedule_block(schedule_block_id)
    JSON.parse(token.get("/api/v1/schedule_blocks/#{schedule_block_id}/appointments").body)
  end

  #I think this method could be done better.
  def get_appointment_on_schedule_block(schedule_block_id, appointment_id)
    JSON.parse(token.get("/api/v1/schedule_blocks/#{schedule_block_id}/appointments/#{appointment_id}").body)
  end

  def create_schedule_block(schedule_block_params)
    token.post("/api/v1/schedule_blocks", schedule_block_params)
  end

  def update_schedule_block(schedule_block_id, schedule_block_params)
    token.put("/api/v1/schedule_blocks/#{schedule_block_id}", schedule_block_params)
  end

  def delete_schedule_block(schedule_block_id)
    token.delete("/api/v1/schedule_blocks/#{schedule_block_id}")
  end
end