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
      flash[:success] = t ".success"
      redirect_to root_url
    else
      flash[:danger] = t ".failed"
      redirect_to new_blog_path
    end
  end

  def edit; end

  def update; end

  def show; end

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
