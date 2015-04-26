class EventsController < ApplicationController
	before_action :set_event, only: [:show, :edit, :update, :destroy]
	
	def index
		@q = Event.ransack(params[:q])
		@events = @q.result
	end

	def show
	end

	def new
		@event = Event.new
	end

	def edit
	end

	def create
		@event = Event.create(event_params)

		if @event.save
			redirect_to event_path(@event)
		else
			render :new
		end
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
			params.require(:event).permit(:rate, :activity_id, :host_id, :location_id)
		end
end
