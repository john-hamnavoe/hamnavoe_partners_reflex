# frozen_string_literal: true

class TaskRepository < ApplicationRepository
  def create(params)
    task = Task.new(params)
    task.project = project
    task.organisation = organisation
    task.save
    task
  end

  def update(id, params)
    task = Task.find_by(id: id)
    task&.update(params)
    task
  end

  def load(id)
    Task.find_by(id: id, organisation: organisation)
  end
end
