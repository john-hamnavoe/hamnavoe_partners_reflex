# frozen_string_literal: true

class CommentsReflex < ApplicationReflex
  def edit
    comment = repo.load(element.dataset[:id])
    morph "#{dom_id(comment.commentable)}_comments", render(partial: "comments/comment_control", locals: { commentable: comment.commentable, edit_comment: comment, doing_edit: true })
  end

  def submit
    comment = if element.dataset[:id].present?
                repo.update(element.dataset[:id], comment_params)
              else
                repo.create(commentable, comment_params)
    end
    morph_to_non_edit_state(comment.commentable)
  end

  def cancel_edit
    comment = repo.load(element.dataset[:id])
    morph_to_non_edit_state(comment.commentable)
  end

  def delete
    comment = repo.delete(element.dataset[:id])
    morph_to_non_edit_state(comment.commentable)
  end

  private

  def morph_to_non_edit_state(commentable)
    morph "#{dom_id(commentable)}_comments", render(partial: "comments/comment_control", locals: { commentable: commentable })
    IssueCommentsJob.perform_now(commentable)
  end

  # remember that variables carry through to controller so if make a variable then name appropriately to not mess with the controller
  def repo
    CommentRepository.new(current_user)
  end

  def comment_params
    params.require(:comment).permit(:body, :parent_id)
  end

  def commentable
    Issue.find(params[:id])
  end
end
