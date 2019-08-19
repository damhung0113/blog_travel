class PlacesController < ApplicationController
  before_action :admin_user, except: %i(index show)
  before_action :load_place, only: %i(show edit update destroy)
  before_action :order_place, only: :index

  def index
    @blogs = Blog.sort_by_time.take(3)
    @title = t params[:status]
  end

  def new
    @place = Place.new
  end

  def show
    @blogs = Blog.sort_by_time.get_blog_by_district(@place.district_id).take(3)
    @commentable = @place
    @comment = @commentable.comments.build
  end

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

  def order_place
    @places = if params[:status] == Settings.place_type
                Place.hotel.find_address(params[:search])
                     .order_by_vote(params[:order])
                     .page(params[:page])
                     .per Settings.paginate
              else
                Place.restaurant.find_address(params[:search])
                     .order_by_vote(params[:order])
                     .page(params[:page])
                     .per Settings.paginate
              end
  end

  def place_params
    params.require(:place).permit Place::PLACE_ATTRIBUTE.freeze
  end

  def load_place
    @place = Place.find_by id: params[:id]

    return if @place
    flash[:danger] = t "not_found"
    redirect_to root_url
  end

  def admin_user
    redirect_to root_url unless current_user.is_admin?
  end
end
