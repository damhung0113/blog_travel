class DistrictsController < ApplicationController
  def new
    @district = District.new
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

  private

  def district_params
    params.require(:district).permit(:name)
  end
end
