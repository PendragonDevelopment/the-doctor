class EventsController < ApplicationController
  before_action :set_event, only: [:edit, :show, :update, :confirm_delete, :destroy, :new_schedule_block, :create_schedule_block, :show_schedule_block, :edit_schedule_block, :update_schedule_block, :block_schedule_block, :confirmation_page]
  before_action :set_one_schedule_block, only: [:block_schedule_block, :edit_schedule_block, :show_schedule_block, :create_appointment]
  before_action :set_all_schedule_blocks, only: [:edit, :show, :confirm_delete]
  before_action :set_sb_service_object, only: [:create_schedule_block, :update_schedule_block]

  def index
    # from DEM branch
    @q = Event.ransack(params[:q])
    @events = @q.result
    @schedule_blocks = ScheduleBlockService.new.get_schedule_blocks if @events
  end

  def create  
    stripped_params = event_params.except(:new_location, :new_activity)
    @event = current_user.host.events.create(stripped_params)
    @event.new_location_from_event_form(event_params[:new_location])
    @event.new_activity_from_event_form(event_params[:new_activity])

    if @event.save
      redirect_to new_schedule_block_event_path(@event.id)
    else
      flash[:notice] = "Event could not be created. Please try again."
      render :new
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
    @event.new_location_from_event_form(event_params[:new_location])
    @event.new_activity_from_event_form(event_params[:new_activity])

    if @event.update(stripped_params)
      flash[:notice] = "Event succesfully updated."
      redirect_to @event
    else
      flash[:notice] = "Event was not updated."
      render :edit
    end
  end

  def confirm_delete
  end

  def destroy
    @event.destroy  
    flash[:notice] = "Event succesfully deleted."
    redirect_to events_path
  end

  #========================================
  # Custom Schedule Block actions below...
  #========================================

    def index_schedule_block
      @event = Event.first
      @schedule_blocks = ScheduleBlockService.new.get_schedule_blocks
    end

    def new_schedule_block
    end

    def create_schedule_block
      stripped_params = params.except(:utf8, :authenticity_token, :commit, :controller, :action, :id)
      if @sb.create_schedule_block(stripped_params)
        redirect_to event_path(@event.id)
        flash[:notice] = "Schedule block succesfully created."
      else
        render :create_schedule_block
        flash[:notice] = "Schedule block was not created."
      end
    end

    def show_schedule_block
    end

    def edit_schedule_block
    end

    def update_schedule_block
      stripped_params = params.except(:utf8, :authenticity_token, :commit, :controller, :action, :schedule_block_id, :id)
      schedule_block_id = params[:schedule_block_id]

      if @sb.update_schedule_block(schedule_block_id, stripped_params)
        redirect_to event_path(@event.id)
        flash[:notice] = "Schedule block was succesfully updated."
      else
        render :edit_schedule_block
        flash[:error] = "Schedule block was not updated."
      end

    end

    def block_schedule_block
    end


  #========================================
  # Custom Appointment actions below...
  #========================================

  def create_appointment
    sb_id = params['schedule_block_id']
    appointment_params = params.except(:schedule_block_id, :authenticity_token, :controller, :action, :id)

    if AppointmentService.new.create_appointment(sb_id, appointment_params)
      redirect_to my_appointments_user_path
      flash[:success] = 'Appointment was succesfully created!'
    else
      render :show_schedule_block
      flash[:error] = 'Appointment was not created!'
    end
  end

  private

    def set_event
      @event = Event.find(params[:id])
    end

    def event_params
      params.require(:event).permit(:event_rate, :location_id, {new_location: [:title]}, :activity_id, {new_activity: [:title]}, :host_id)
    end

    def set_one_schedule_block
      @schedule_block = ScheduleBlockService.new.get_schedule_block(params[:sb_id])
    end

    def set_all_schedule_blocks
      @schedule_blocks = ScheduleBlockService.new.get_schedule_blocks.select{|sb| sb['event_id'] == @event.id }
    end

    def set_sb_service_object
      @sb = ScheduleBlockService.new
    end


end