class EventsController < ApplicationController
  before_action :set_event, :only => [:edit, :show, :update, :destroy]

  def index
    @events = Event.all
  end

  def create
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

    # Selects
    schedule_block_params = event_params.select {|k,v| ['params'].include?(k)}

    if @event.save
      # Adds neccessary attributes to params for Schedule Block creation from newly created Event
      schedule_block_params[:params][:host_id] = @event.host.id
      schedule_block_params[:params][:event_id] = @event.id
      schedule_block_params[:params][:location_id] = @event.location_id
      schedule_block_params[:params][:status] = 'open'

      if @event.create_schedule_block(schedule_block_params)
        redirect_to @event
        flash[:notice] = "Event & Schedule Block succesfully created!"
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
    @schedule_block = @event.get_schedule_block(15)
  end

  def show
    @schedule_block = @event.get_schedule_block(15)
  end

  def update
    if @event.update(event_params)
      redirect_to event_path(@event)
    else
      render :edit
    end
  end

  def destroy
    @event.destroy
    redirect_to root_url
  end

  private

    def set_event
      @event = Event.find(params[:id])
    end

    def event_params
      params.require(:event).permit(:rate, :location_id, {new_location: [:new_location]}, :activity_id, {new_activity: [:new_activity]},:host_id, { params: [:host_id, :event_id, :location_id, :start_time, :end_time, :reservation_min, :reservation_max, :status] })
    end
end
