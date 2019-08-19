class SessionsController < ApplicationController
  def new; end

  def create
    if params[:session].present?
      login_normal
    else
      login_with_facebook
    end
  end

  def destroy
    log_out
    redirect_to login_path
  end

  private

  def get_session_email
    params[:session][:email].downcase
  end

  def check_session_remember
    params[:session][:remember_me] == "1"
  end

  def login_normal
    user = User.find_by email: get_session_email

    if user && user.authenticate(params[:session][:password])
      flash[:success] = t ".welcome", name: user.name
      log_in user
      check_session_remember ? remember(user) : forget(user)
      redirect_to root_url
    else
      flash.now[:danger] = t("controllers.session.err")
      render :new
    end
  end

  def login_with_facebook
    user = User.from_omniauth(request.env["omniauth.auth"])
    flash[:success] = t ".welcome", name: user.name
    log_in user
    redirect_to root_url
  rescue StandardError
    flash[:waring] = "There was an error while trying to authenticate you"
  end
end
