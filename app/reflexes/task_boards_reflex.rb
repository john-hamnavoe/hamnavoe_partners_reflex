# frozen_string_literal: true

class TaskBoardsReflex < ApplicationReflex
  def new
    @task_board = TaskBoard.new
  end

  def edit
    @task_board = repo.load(element.dataset[:id])
  end

  private

  # remember that variables carry through to controller so if make a variable then name appropriately to not mess with the controller
  def repo
    TaskBoardRepository.new(current_user)
  end
end
