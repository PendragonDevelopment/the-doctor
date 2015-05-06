class EventsController < ApplicationController
  before_action :set_event, :only => [:edit, :show, :update, :confirm_delete, :destroy, :new_schedule_block, :create_schedule_block, :show_schedule_block, :edit_schedule_block, :update_schedule_block, :block_schedule_block]

  def index
    # from DEM branch
    @q = Event.ransack(params[:q])
    @events = @q.result
    if Event.first then
      @event = Event.first
      @schedule_blocks = @event.get_schedule_blocks
    end
  end

  def create
    # To exclude new_location and new_activity params
    stripped_params = event_params.except(:new_location, :new_activity)

    @event = current_user.host.events.create(stripped_params)
    
    # Allows for creation and selection of a new Location through form
    new_location = event_params[:new_location][:title]
    unless new_location.empty?
      if Location.where(title: new_location).empty?
        new_location_record = @event.create_location(title: new_location)
        @event.update_attributes(location_id: new_location_record.id )
      else
        redirect_to new_event_path
        flash[:error] = "You cannot create a location that already exists!"
        return
      end
    end
    
    # Allows for creation and selection of a new Activity through form
    new_activity = event_params[:new_activity][:title]
    unless new_activity.empty?
      if Activity.where(title: new_activity).empty?
        new_activity_record = @event.create_activity(title: new_activity)
        @event.update_attributes(activity_id: new_activity_record.id)
      else
        redirect_to new_event_path
        flash[:error] = "You cannot create an activity that already exists!"
        return
      end
    end

    if @event.save
      redirect_to new_schedule_block_event_path(@event.id)
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
    @schedule_blocks = @event.get_schedule_blocks.select{|sb| sb['event_id'] == @event.id }
  end

  def show
    @schedule_blocks = @event.get_schedule_blocks.select{|sb| sb['event_id'] == @event.id }
  end

  def update
    stripped_params = event_params.except(:new_location, :new_activity)
  
    # Allows for creation and selection of a new Location through form
    # However, this creates a location with only a title, we need to add fields for Location description, latitude and longitude 
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
      redirect_to @event
      flash[:notice] = "Event succesfully updated."
    else
      render :edit
      flash[:notice] = "Event was not updated."
    end
  end

  def confirm_delete
    @schedule_blocks = @event.get_schedule_blocks.select{|sb| sb['event_id'] == @event.id }
  end

  def destroy
    @event.destroy    
    redirect_to events_path
    flash[:notice] = "Event succesfully deleted."
  end

  #========================================
  # Custom Schedule Block actions below...
  #========================================

    def index_schedule_block
      @event = Event.first
      @schedule_blocks = @event.get_schedule_blocks
    end

    def new_schedule_block
    end

    def create_schedule_block
      stripped_params = params.except(:utf8, :authenticity_token, :commit, :controller, :action, :id)
      puts "Params = #{stripped_params}"
      if @event.create_schedule_block(stripped_params)
        redirect_to event_path(@event.id)
        flash[:notice] = "Schedule block succesfully created."
      else
        render :create_schedule_block
        flash[:notice] = "Schedule block was not created."
      end
    end

    def show_schedule_block
      @schedule_block = @event.get_schedule_block(params[:sb_id])
    end

    def edit_schedule_block
      @schedule_block = @event.get_schedule_block(params[:sb_id])
    end

    def update_schedule_block
      stripped_params = params.except(:utf8, :authenticity_token, :commit, :controller, :action, :schedule_block_id, :id)
      schedule_block_id = params[:schedule_block_id]
      puts "Schedule block ID = #{schedule_block_id}"
      puts "Stripped params = #{stripped_params}"

      if @event.update_schedule_block(schedule_block_id, stripped_params)
        redirect_to event_path(@event.id)
        flash[:notice] = "Schedule block was succesfully updated."
      else
        render :edit_schedule_block
        flash[:error] = "Schedule block was not updated."
      end

    end

    def block_schedule_block
      @schedule_block = @event.get_schedule_block(params[:sb_id])
    end

  private

    def set_event
      @event = Event.find(params[:id])
    end

    def event_params
      params.require(:event).permit(:event_rate, :location_id, {new_location: [:title]}, :activity_id, {new_activity: [:title]}, :host_id)
    end

  end