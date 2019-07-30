class PlacesController < ApplicationController
  before_action :find_place, only: %i(show edit update destroy)

  def index
    @places = Place.send(params[:status]).page(params[:page]).per Settings.paginate
    @title = t params[:status]
  end

  def new
    @place = Place.new
  end

  def show; end

  def edit; end

  def create
    @place = Place.new place_params

    if @place.save
      flash[:success] = t "create_success"
      redirect_to places_path(status: @place.status)
    else
      flash[:warning] = t "create_fail"
      render :new
    end
  end

  def update
    if @place.update_attributes place_params
      flash[:success] = t "update_success"
      redirect_to places_path(status: @place.status)
    else
      render :edit
    end
  end

  def destroy
    if @place.destroy
      flash[:success] = t "delete_success"
      redirect_to places_path(status: @place.status)
    else
      flash[:danger] = t "delete_fail"
      redirect_to root_path
    end
  end

  private

  def place_params
    params.require(:place).permit Place::PLACE_ATTRIBUTE.freeze
  end

  def find_place
    @place = Place.find_by id: params[:id]

    return if @place
    flash[:danger] = t "not_found"
    redirect_to root_url
  end
end
