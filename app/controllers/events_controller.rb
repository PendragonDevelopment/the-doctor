class EventsController < ApplicationController
  before_action :set_event, :only => [:edit, :show, :update, :destroy]

  def index
    @events = Event.all
  end

  def create
    only_event_params = event_params.select {|k,v| ['rate', 'location_id', 'new_location', 'activity_id', 'host_id'].include?(k)}
    #schedule_block_params_hash = event_params.select {|k,v| ['schedule_block_params'].include?(k)}
    #schedule_block_params = schedule_block_params_hash['schedule_block_params']

    @event = current_user.host.events.build(only_event_params)

# quote_params = {'host_id' => 1,'event_id' => 1, 'location_id' => 1,'start_time' => "2015-04-23T17:35:08-04:00", 'end_time' => "2015-04-23T19:35:08-04:00",'reservation_min' => 1, 'reservation_max' => 1000, 'status' => 1, 'user_id' => 1}

# colon_params = {host_id: 1, event_id: 1, location_id: 1, start_time: "2015-04-23T17:35:08-04:00", end_time: "2015-04-23T19:35:08-04:00", reservation_min: 1, reservation_max: 1000, status: 1, user_id: 1}

    if @event.save
      @event.create_schedule_block(copied_params)
      if @event.create_schedule_block(copied_params)
        #({schedule_block_params:{host_id:1, event_id:2, location_id:2, start_time:'2016-02-03 5:00:00', end_time:'2016-02-03 6:00:00', reservation_min:2, reservation_max:10, status:'full'}})
        redirect_to @event
        flash[:notice] = "Event & Schedule Block succesfully created!"
        flash[:debug] = "#{copied_params}"
        flash[:extra] = "#{only_event_params}"
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
      params.require(:event).permit(:rate, :location_id, :new_location, :activity_id, :host_id, { schedule_block_params: [:start_time, :end_time, :reservation_min, :reservation_max] })
    end
end
