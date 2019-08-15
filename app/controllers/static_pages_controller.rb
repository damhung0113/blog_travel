class StaticPagesController < ApplicationController
  def home
    @blogs = Blog.sort_by_like.take(Settings.blogs.all_blog.take_6)
    @places = Place.take(Settings.blogs.all_blog.take_6)
  end
end
