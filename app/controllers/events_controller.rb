class EventsController < ApplicationController
  before_action :set_event, :only => [:edit, :show, :update, :confirm_delete, :destroy, :new_schedule_block]
  before_action :set_schedule_blocks, :only => [:edit, :update, :confirm_delete, :destroy]

  def index
    # from DEM branch
    @q = Event.ransack(params[:q])
    @events = @q.result

    @event = Event.first
    @schedule_blocks = @event.get_schedule_blocks
  end

  def create
    # To exclude new_location and new_activity params
    stripped_params = event_params.except(:new_location, :new_activity)

    @event = current_user.host.events.create(stripped_params)
    
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
      redirect_to events_path
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
  end

  def show
  end

  def update
    stripped_params = event_params.except(:new_location, :new_activity)
    
    # The location_id is the only attribute that needs to be updated on a Schedule Block, everything else regarding the Event is only on the Event model

    puts "Stripped event params = #{stripped_params}"

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

    if @event.update(stripped_params)
      # Update associated Schedule Blocks
      redirect_to @events
      flash[:notice] = "Event succesfully updated."
    else
      render :edit
      flash[:notice] = "Event was not updated."
    end
  end

  def confirm_delete
  end

  def destroy
    @event.destroy    
    @schedule_blocks.each {|sb| @event.delete_schedule_block(sb['id']) }
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

    def set_schedule_blocks
      @schedule_blocks = @event.get_schedule_blocks.select{|sb| sb['event_id'] == @event.id}
    end

  end