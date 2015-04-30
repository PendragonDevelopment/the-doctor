class EventsController < ApplicationController
  before_action :set_event, :only => [:edit, :show, :update, :delete, :destroy, :new_schedule_block]

  def index
    # from DEM branch
    @q = Event.ransack(params[:q])
    @events = @q.result

    @events = Event.all
  end

  def create
    # To exclude new_location and new_activity params
    event_model_params = event_params.select {|k,v| ['rate', 'location_id', 'activity_id', 'host_id'].include?(k)}

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
      redirect_to new_schedule_block_event_path(@event.id)
    else
      render :new
      flash[:notice] = "Event could not be created. Please try again."
    end
  end

  def new_schedule_block
    if request.post?
      @event = Event.find(params[:id])
      schedule_block_wrapped_params = params.select{|k,v| ['schedule_block'].include?(k)}

      schedule_block_params = Hash.new
      schedule_block_params['reservation_max'] = schedule_block_wrapped_params[:schedule_block][:reservation_max]
      schedule_block_params['reservation_min'] = schedule_block_wrapped_params[:schedule_block][:reservation_min]
      schedule_block_params['start_time'] = '2015-04-29T17:28:02-04:00'
      schedule_block_params['end_time'] = '2015-04-29T18:28:02-04:00'
      schedule_block_params['host_id'] = "#{@event.host_id}"
      schedule_block_params['event_id'] = "#{@event.id}"
      schedule_block_params['location_id'] = "#{@event.location_id}"
      schedule_block_params['status'] = 'open'

      # For debugging purposes, delete after use
      puts "schedule_block_params = #{schedule_block_params}"
      
      if @event.create_schedule_block(schedule_block_params)
        redirect_to events_path
      else
        redirect_to new_schedule_block_event_path
      end
    else
      # GET REQUEST
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
    @sb_ID = sb_event_id.to_i

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
      params.require(:event).permit(:rate, :location_id, {new_location: [:new_location]}, :activity_id, {new_activity: [:new_activity]},:host_id, {params: [:host_id, :event_id, :location_id, :start_time, :end_time, :reservation_min, :reservation_max, :status]})
    end

    def schedule_block_params
      params.require(:event).permit(:rate, :location_id, {new_location: [:new_location]}, :activity_id, {new_activity: [:new_activity]},:host_id, {params: [:host_id, :event_id, :location_id, :start_time, :end_time, :reservation_min, :reservation_max, :status]})
    end
  end