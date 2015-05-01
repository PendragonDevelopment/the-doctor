class ScheduleBlocksController < ApplicationController
   before_action :set_event_and_schedule_block, #:only => [:edit, :show, :update, :destroy]

  def index
    @event_schedule_blocks = @all_schedule_blocks.select{|sb| sb['event_id'] == @event.id }
  end

  def create
    stripped_params = params.except(:utf8, :authenticity_token, :commit, :controller, :action)

    if @event.create_schedule_block(stripped_params)
      render :index
    else
      render :new
      flash[:notice] = "Schedule Block create method was not called."
    end
  end

  def new
  end

  def edit
  end

  def show
  end

  def update
  end

  def confirm_delete
  end

  def destroy
  end

  private

    def set_event_and_schedule_block
      @event_id = (params[:event_id]).to_i
      @sb_id = (params[:id]).to_i

      @event = Event.find(@event_id)
      @all_schedule_blocks = @event.get_schedule_blocks
      @schedule_block = @all_schedule_blocks.select{|sb| sb['id'] == @sb_id}.first
    end

end
