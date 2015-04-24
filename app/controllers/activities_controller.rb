class ActivitiesController < ApplicationController
	before_action :set_activity, only: [:show, :edit, :update, :destroy]
	
	def index
		@activities = Activity.all
	end

	def show
	end

	def new
		@activity = Activity.new
	end

	def edit
	end

	def create
		@activity = Activity.create(activity_params)

		if @activity.save
			redirect_to activity_path(@activity)
		else
			render :new
		end
	end

	def update
		if @activity.update(activity_params)
			redirect_to activity_path(@activity)
		else
			render :edit
		end
	end

	def destroy
		@activity.destroy
		redirect_to root_url
	end

	private

		def set_activity
			@activity = Activity.find(params[:id])
		end

		def activity_params
			params.require(:activity).permit(:title)
		end
end
