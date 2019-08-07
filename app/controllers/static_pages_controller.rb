class StaticPagesController < ApplicationController
  def home
    @blogs = Blog.sort_by_time.take(Settings.blogs.all_blog.take_6)
  end
end
