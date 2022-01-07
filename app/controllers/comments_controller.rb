# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :user_in_organisation!

  def create
    @comment = repo.create(@commentable, comment_params)

    redirect_to issues_path
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :parent_id)
  end

  def repo
    @repo ||= CommentRepository.new(current_user)
  end
end
