# frozen_string_literal: true

class TaskListsReflex < ApplicationReflex
  def new
    @task_list = TaskList.new
    @task_list.task_board_id = element.dataset[:id].to_i
  end

  def edit
    @edit_task_list_id = element.dataset[:id].to_i
  end

  def cancel_edit
    @edit_task_list_id = nil
  end

  def update
    value = element[:value]
    repo.update(element.dataset[:id], { name: value })
  end

  private

  # remember that variables carry through to controller so if make a variable then name appropriately to not mess with the controller
  def repo
    TaskListRepository.new(current_user)
  end
end
