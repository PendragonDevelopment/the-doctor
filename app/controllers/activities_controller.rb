class ActivitiesController < ApplicationController
  before_action :set_activity, :only => [:edit, :show, :update, :destroy]

  def index
    @activities = Activity.all
  end

  def create
    @activity = Activity.create(activity_params)

    if @activity.save
      redirect_to @activity
    else
      redirect_to new_activity_path
    end
    
  end

  def new
    @activity = Activity.new
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

    def set_activity
      @activity = Activity.find(params[:id])
    end

    def activity_params
      params.require(:activity).permit(:title)
    end
end
