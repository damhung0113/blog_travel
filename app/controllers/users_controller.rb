class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new user_params

    if @user.save
      flash.now[:success] = t("controllers.user.welcome")
      redirect_to @user
    else
      render :new
    end
  end

  def show
    @user = User.find_by id: params[:id]

    return if @user
    flash.now[:danger] = t("user.show.not_exits")
  end

  private
    def user_params
      params.require(:user).permit :name, :email, :password, :password_confirmation
    end

    def logged_in_user
      
      return if logged_in?
      store_location
      flash[:danger] = t("controllers.user.please_ln")
      redirect_to login_url
    end
end
