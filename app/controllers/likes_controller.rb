class LikesController < ApplicationController
  before_action :logged_in_user, only: %i(create destroy)
  before_action :correct_like, only: :destroy
  before_action :load_blog

  def create
    @like = @blog.likes.build
    @like.user_id = current_user.id
    if @like.save
      respond_to do |format|
        format.js
        format.html
      end
    else
      flash[:danger] = t "create_fail"
      redirect_to root_url
    end
  end

  def destroy
    if @like.destroy
      respond_to do |format|
        format.js
        format.html
      end
    else
      flash[:danger] = t "destroy_fail"
      redirect_to root_url
    end
  end

  private

  def load_blog
    @blog = Blog.find_by id: params[:blog_id]

    return if @blog
    flash[:danger] = t "not_found"
    redirect_to root_url
  end

  def correct_like
    @like = current_user.likes.find_by id: params[:id]

    return if @like
    flash[:danger] = t "not_found"
    redirect_to root_url
  end
end
