class DistrictsController < ApplicationController
  before_action :find_district, only: :destroy

  def new
    @district = District.new
    @districts = District.order_district.page(params[:page])
                         .per Settings.paginate
    @count = District.count
  end

  def create
    @district = District.new district_params

    if @district.save
      flash[:success] = t "create_success"
    else
      flash[:danger] = t "create_fail"
    end
    redirect_to new_district_path
  end

  def destroy
    if @district.destroy
      flash[:success] = t "delete_success"
    else
      flash[:danger] = t "delete_fail"
    end
    redirect_to new_district_path
  end

  private

  def district_params
    params.require(:district).permit(:name)
  end

  def find_district
    @district = District.find_by id: params[:id]

    return if @district
    flash[:danger] = t "not_found"
    redirect_to root_url
  end
end
