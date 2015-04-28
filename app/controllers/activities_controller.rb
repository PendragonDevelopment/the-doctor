class ActivitiesController < ApplicationController
  before_action :set_activity, :only => [:edit, :show, :update, :destroy]

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
    activity_model_params = activity_params.select{|k,v| ['title'].include?(k)}
    @activity = Activity.create(activity_model_params)
    @activity.tag_list.add(activity_params[:tags][:tags], parse: true)

    if @activity.save
      redirect_to @activity
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
    redirect_to activities_path
  end

  private

    def set_activity
      @activity = Activity.find(params[:id])
    end

    def activity_params
      params.require(:activity).permit(:title, tags: [:tags])
    end
end
