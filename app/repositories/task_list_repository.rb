# frozen_string_literal: true

class TaskListRepository < ApplicationRepository
  def create(params)
    task_list = TaskList.new(params)
    task_list.project = project
    task_list.organisation = organisation
    task_list.save
    task_list
  end

  def update(id, params)
    task_list = TaskList.find_by(id: id)
    task_list&.update(params)
    task_list
  end
end
