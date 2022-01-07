# frozen_string_literal: true

class CommentsReflex < ApplicationReflex

  def post
    value = element[:value]
    @comment = repo.create(@commentable, {body: value})
  end

  private

  # remember that variables carry through to controller so if make a variable then name appropriately to not mess with the controller
  def repo
    CommentRepository.new(current_user)
  end
end

