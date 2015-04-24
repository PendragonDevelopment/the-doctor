class EventsController < ApplicationController
  before_action :set_event, :only => [:edit, :show, :update, :destroy]

  def index
    @events = Event.all
  end

  def create
    event_model_params = event_params.select {|k,v| ['rate', 'location_id', 'activity_id', 'host_id'].include?(k)}

    @event = current_user.host.events.create(event_model_params)
    
    new_location = event_params[:new_location][:new_location]
    unless new_location.empty?
      new_location_record = @event.create_location(title: new_location)
      @event.update_attributes(location_id: new_location_record.id )
    end
    
    new_activity = event_params[:new_activity][:new_activity]
    unless new_activity.empty?
      new_activity_record = @event.create_activity(title: new_activity)
      @event.update_attributes(activity_id: new_activity_record.id)
    end

    #schedule_block_params_hash = event_params.select {|k,v| ['schedule_block_params'].include?(k)}
    #schedule_block_params = schedule_block_params_hash['schedule_block_params']

    hard_coded_params = {'host_id' => 1,'event_id' => 1, 'location_id' => 1,'start_time' => "2015-04-23T17:35:08-04:00", 'end_time' => "2015-04-23T19:35:08-04:00",'reservation_min' => 1, 'reservation_max' => 1000, 'status' => 1, 'user_id' => 1}

    if @event.save
      if @event.create_schedule_block(hard_coded_params)
        redirect_to @event
        flash[:notice] = "Event & Schedule Block succesfully created!"
        flash[:debug] = "#{hard_coded_params}"
        flash[:extra] = "#{event_model_params}"
      else
        redirect_to @event
        flash[:notice] = "Event created, but Schedule Block was NOT!"
        flash[:debug] = "#{schedule_block_params}"
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
  end

  def show
    @schedule_blocks = @event.get_schedule_blocks
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
      params.require(:event).permit(:rate, :location_id, {new_location: [:new_location]}, :activity_id, {new_activity: [:new_activity]},:host_id, { schedule_block_params: [:start_time, :end_time, :reservation_min, :reservation_max] })
    end
end
