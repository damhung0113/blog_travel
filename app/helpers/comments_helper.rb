module CommentsHelper
  def comments_tree_for comments, commentable, comment_new
    safe_join(comments.map do |comment, nested_comments|
      render(comment, commentable: commentable,
        comment_new: comment_new) + tree(nested_comments, commentable)
    end)
  end

  def tree nested_comments, commentable
    unless nested_comments.empty?
      content_tag :div,
        comments_tree_for(nested_comments, commentable, Comment.new),
        class: "replies"
    end
  end
end
