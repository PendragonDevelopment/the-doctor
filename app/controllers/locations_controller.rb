class LocationsController < ApplicationController
  before_action :set_location, :only => [:edit, :show, :update, :destroy]

  def index
    @locations = Location.all
  end

  def create
    @location = Location.create(location_params)

    if @location.save
      redirect_to @location
    else
      render :new
    end
  end

  def new
    @location = Location.new
  end

  def edit
  end

  def show
  end

  def update
    if @location.update(location_params)
      redirect_to location_path(@location)
    else
      render :edit
    end
  end

  def destroy
    @location.destroy
    redirect_to root_url
  end

  private

    def set_location
      @location = Location.find(params[:id])
    end

    def location_params
      params.require(:location).permit(:title, :description, :latitude, :longitude)
    end

end

