class BookmarksController < ApplicationController
  before_action :load_blog_place, only: :create
  before_action :load_bookmark, only: :destroy

  def create
    if params[:type] == Settings.blog_s
      @get_bookmark_blog = Bookmark.get_bookmark(current_user.id,
        @blog.id, Settings.blog_s)
      @bookmark_blog = current_user.bookmarks.build bookmarkable: @blog

      respond_to do |format|
        format.js if @bookmark_blog.save
      end
    else
      @get_bookmark_place = Bookmark.get_bookmark(current_user.id,
        @place.id, Settings.place_s)
      @bookmark_place = current_user.bookmarks.build bookmarkable: @place

      respond_to do |format|
        format.js if @bookmark_place.save
      end
    end
  end

  def destroy
    if @bookmark.bookmarkable_type == Settings.blog_s
      @blog_bookmarked = Blog.get_blog(@bookmark.bookmarkable_id).first
      @destroy = Settings.blog_s
    else
      @place_bookmarked = Place.get_place(@bookmark.bookmarkable_id).first
      @destroy = Settings.place_s
    end

    respond_to do |format|
      format.js if @bookmark.destroy
    end
  end

  private

  def load_blog_place
    @blog = Blog.find_by id: params[:blog_id]
    @place = Place.find_by id: params[:place_id]
    render file: "public/404.html", layout: false unless @place || @blog
  end

  def load_bookmark
    @bookmark = Bookmark.find_by id: params[:id]
    render file: "public/404.html", layout: false unless @bookmark
  end
end
