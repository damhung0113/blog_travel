class BlogsController < ApplicationController
  before_action :load_blog, except: %i(index new create)
  before_action :logged_in_user, except: %i(new create show)

  def index
    @blogs = Blog.all
  end

  def new
    @blog = current_user.blogs.build
    @districts_name = District.pluck :name
  end

  def create
    @blog = current_user.blogs.build blog_params

    if district_params.present?
      @blog.district_id = District.district_by_name(district_params).first.id
    end

    if @blog.save
      flash[:success] = t ".success_create"
      redirect_to root_url
    else
      flash[:danger] = t ".failed_create"
      redirect_to new_blog_path
    end
  end

  def edit
    @districts_name = District.pluck :name
  end

  def update
    if @blog.update blog_params
      flash[:success] = t ".success_update"
      redirect_to @blog
    else
      flash[:danger] = t ".failed_update"
      redirect_to edit_blog_path
    end
  end

  def show; end

  def destroy
    if @blog.destroy
      flash[:success] = t ".success_destroy"
      redirect_to blogs_path
    else
      flash[:danger] = t ".failed_destroy"
    end
  end

  private

  def blog_params
    params.require(:blog).permit :topic, :content, :cover_photo, :address
  end

  def load_blog
    @blog = Blog.find_by id: params[:id]
    render file: "public/404.html", layout: false unless @blog
  end

  def district_params
    @district_params = params[:blog][:district]
  end
end
