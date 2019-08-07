class UsersController < ApplicationController
  before_action :load_user, except: %i(index new create)
  before_action :admin_user, only: %i(destroy index)
  before_action :correct_user, only: %i(update edit)
  before_action :logged_in_user, except: %i(new create show)

  def index
    @users = User.sort_by_name.page(params[:page]).per 10
  end

  def show
    @users = @user.followers.page(params[:page]).per 10
    return if @user
    flash.now[:danger] = t("user.show.not_exits")
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params

    if @user.save
      flash.now[:success] = t("controllers.user.welcome")
      redirect_to login_path param: @user.email
    else
      render :new
    end
  end

  def edit; end

  def update
    if @user.update user_params
      flash[:success] = t ".update_success"
      redirect_to @user
    else
      flash.now[:danger] = t ".update_failed"
      render :edit
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = t ".delete_done"
      redirect_to @user
    else
      flash[:danger] = t ".delete_failed"
    end
  end

  private

  def user_params
    params.require(:user).permit :name, :email, :password,
      :password_confirmation, :avatar
  end

  def admin_user
    return if current_user.is_admin?
    flash[:danger] = t "waring_admin"
    redirect_to root_url
  end

  def correct_user
    redirect_to edit_user_path current_user unless current_user? @user
  end

  def load_user
    @user = User.find_by id: params[:id]
    render file: "public/404.html", layout: false unless @user
  end
end
