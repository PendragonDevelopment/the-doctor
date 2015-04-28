class EventsController < ApplicationController
  before_action :set_event, :only => [:edit, :show, :update, :delete, :destroy]

  def index
    @events = Event.all

    # Only set @event to be able to call get_schedule_blocks below
    if @events.count >= 1 
      @event = @events.first
      @schedule_blocks = @event.get_schedule_blocks
    end
  end

  def create
    # Select ONLY Event model attributes from form params
    event_model_params = event_params.select {|k,v| ['rate', 'location_id', 'activity_id', 'host_id'].include?(k)}

    # Selects ONLY Schedule Block params from form params
    schedule_block_params = event_params.select {|k,v| ['params'].include?(k)}

    @event = current_user.host.events.create(event_model_params)
    
    # Allows for creation and selection of a new Location through form
    new_location = event_params[:new_location][:new_location]
    unless new_location.empty?
      new_location_record = @event.create_location(title: new_location)
      @event.update_attributes(location_id: new_location_record.id )
    end
    
    # Allows for creation and selection of a new Activity through form
    new_activity = event_params[:new_activity][:new_activity]
    unless new_activity.empty?
      new_activity_record = @event.create_activity(title: new_activity)
      @event.update_attributes(activity_id: new_activity_record.id)
    end

    if @event.save
      # Adds neccessary attributes to params for Schedule Block creation from newly created Event
      schedule_block_params[:params][:host_id] = @event.host.id
      schedule_block_params[:params][:event_id] = @event.id
      schedule_block_params[:params][:location_id] = @event.location_id
      schedule_block_params[:params][:status] = 'open'
      if @event.create_schedule_block(schedule_block_params)
        redirect_to @event
      else
        redirect_to @event
        flash[:notice] = "Event created, but Schedule Block was NOT!"
      end
    else
      render :new
      flash[:notice] = "Event could not be created. Please try again."
    end
  end

  def new
    @event = Event.new
    @activity_options = Activity.all.map{|x| [x.title]}
    @activity = @event.build_activity
    @host = @event.build_host
    @location_options = Location.all.map{|x| [x.title]}
    @location = @event.build_location
  end

  def edit
    schedule_blocks = @event.get_schedule_blocks
    sb_event_id = (params[:id]).to_i
    schedule_block_array = schedule_blocks.select{|sb| sb['event_id'] == sb_event_id }
    @schedule_block = schedule_block_array.first
  end

  def show
    @schedule_block = @event.get_schedule_block(15)
  end

  def update
    sb_event_id = params['schedule_block_ID']

    # Select ONLY Event model attributes from form params
    event_model_params = event_params.select {|k,v| ['rate', 'location_id', 'activity_id', 'host_id'].include?(k)}

    # Selects ONLY Schedule Block params from form params
    schedule_block_params = event_params.select {|k,v| ['params'].include?(k)}

    if @event.update(event_model_params)
      # Adds neccessary attributes to params for Schedule Block creation from newly created Event
      schedule_block_params[:params][:host_id] = @event.host.id
      schedule_block_params[:params][:event_id] = @event.id
      schedule_block_params[:params][:location_id] = @event.location_id
      schedule_block_params[:params][:status] = 'open'

      if @event.update_schedule_block(@sb_ID, schedule_block_params)
        redirect_to events_path
      else
        render :edit
      end
    else
      render :edit
    end
  end

  def delete
    sb_ID = params['schedule_block_ID']
    @schedule_block = @event.get_schedule_block(sb_ID)
  end

  def destroy
    @event.destroy
    sb_ID = params['schedule_block_ID']
    @event.delete_schedule_block(sb_ID)
    redirect_to events_path
  end

  private

    def set_event
      @event = Event.find(params[:id])
    end

    def event_params
      params.require(:event).permit(:rate, :location_id, {new_location: [:new_location]}, :activity_id, {new_activity: [:new_activity]},:host_id, { params: [:host_id, :event_id, :location_id, :start_time, :end_time, :reservation_min, :reservation_max, :status] })
    end
end
