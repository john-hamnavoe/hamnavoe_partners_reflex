# frozen_string_literal: true

class TasksReflex < ApplicationReflex
  def new
    @task = Task.new
    @task.task_list_id = element.dataset[:id].to_i
  end

  def edit
    @task = repo.load(element.dataset[:id].to_i)
  end

  def cancel_edit
    @task = nil
  end

  def update
    value = element[:value]
    repo.update(element.dataset[:id], { name: value })
  end

  private

  # remember that variables carry through to controller so if make a variable then name appropriately to not mess with the controller
  def repo
    TaskRepository.new(current_user)
  end
end
