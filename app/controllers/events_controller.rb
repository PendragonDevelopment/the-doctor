class EventsController < ApplicationController
  before_action :set_event, :only => [:edit, :show, :update, :destroy]

  def index
    @events = Event.all
  end

  def create
    @event = current_user.host.events.build(event_params)
    #@event.build_host(event_params[:host])
    #@event.build_activity(event_params[:activity_attributes])
    #@event.host(event_params[:host_attributes])

    if @event.save
      redirect_to @event
    else
      redirect_to new_event_path
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
  end

  def destroy
  end

  private

    def set_event
      @event = Event.find(params[:id])
    end

    def event_params
      params.require(:event).permit(:rate, :location_id, :new_location, :activity_id, :host_id)
    end
end
