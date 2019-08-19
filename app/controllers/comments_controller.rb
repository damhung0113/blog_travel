class CommentsController < ApplicationController
  before_action :logged_in_user
  before_action :load_commentable, only: :create
  before_action :correct_comment, only: :destroy

  def create
    @id = params[:comment][:parent_id].to_i

    if @id > 0
      parent = @commentable.comments.find_by(id: @id)
      @comment = parent.children.build comment_params
      @comment.user_id = current_user.id
      @comment.commentable_id = @commentable.id
      @comment.commentable_type = parent.commentable_type
    else
      @comment = @commentable.comments.build comment_params
      @comment.user_id = current_user.id
    end

    if @comment.save
      flash[:success] = t "create_success"

      if @comment.commentable_type == Settings.blog_s
        redirect_to blog_path(id: @comment.commentable_id)
      else
        redirect_to place_path(id: @comment.commentable_id)
      end
    else
      flash[:danger] = t "create_fail"
      redirect_to root_url
    end
  end

  def destroy
    @comment.descendants.each(&:destroy)

    if @comment.destroy
      flash[:success] = t "delete_success"

      if @comment.commentable_type == Settings.blog_s
        redirect_to blog_path(id: @comment.commentable_id)
      else
        redirect_to place_path(id: @comment.commentable_id)
      end
    else
      flash[:danger] = t "delete_fail"
      render root_path
    end
  end

  private

  def comment_params
    params.require(:comment).permit :content
  end

  def load_commentable
    @type = params[:comment][:type]

    @commentable = if @type == "Blog"
                     Blog.find_by id: params[:comment][:commentable_id]
                   else
                     Place.find_by id: params[:comment][:commentable_id]
                   end

    return if @commentable
    flash[:danger] = t "not_found"
    redirect_to root_url
  end

  def correct_comment
    @comment = current_user.comments.find_by id: params[:id]

    return if @comment
    flash[:danger] = t "not found"
    redirect_to root_url
  end
end
