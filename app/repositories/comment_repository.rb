# frozen_string_literal: true

class CommentRepository < ApplicationRepository
  def create(commentable, params)
    comment = commentable.comments.new(params)
    comment.user = user
    comment.save
  end
end
