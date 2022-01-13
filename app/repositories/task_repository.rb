# frozen_string_literal: true

class TaskRepository < ApplicationRepository
  def all(args, params, order_by, direction, restrict_by_project = true)
    query = Task.eager_load([:assigned_to, task_list: [:task_board]]).where(organisation: organisation).where(args)
    query = query.where(project: project) if restrict_by_project
    query = query.where("lower(title) LIKE :keyword", keyword: "%#{params[:keywords].downcase}%") if params && params[:keywords].present?
    #query = query.where(is_active: params[:is_active]) if params && params[:is_active].present?

    query.order(order_by => direction)
  end

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
