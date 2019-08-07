class SessionsController < ApplicationController
  def new; end

  def create
    if params[:session].present?
      user = User.find_by_email params[:session][:email].downcase

      if user&.authenticate params[:session][:password]
        flash[:success] = t ".welcome", name: user.name
        log_in user
        params[:session][:remember_me] == "1" ? remember(user) : forget(user)
        redirect_to root_url
      else
        flash.now[:danger] = t("controllers.session.err")
        render :new
      end
    else
      begin
        user = User.from_omniauth(request.env["omniauth.auth"])
        flash[:success] = t ".welcome", name: user.name
        log_in user
        redirect_to root_url
      rescue
        flash[:waring] = t ".waring"
      end
    end
  end

  def destroy
    log_out
    redirect_to login_path
  end
end
