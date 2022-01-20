# frozen_string_literal: true

class CommentRepository < ApplicationRepository
  def create(commentable, params)
    comment = commentable.comments.new(params)
    comment.user = user
    comment.save
    comment
  end

  def update(id, params)
    comment = Comment.find_by(id: id, user: user)
    comment&.update(params)
    comment
  end

  def delete(id)
    comment = Comment.find_by(id: id, user: user)
    comment&.destroy
    comment
  end

  def load(id)
    Comment.find_by(id: id)
  end
end
