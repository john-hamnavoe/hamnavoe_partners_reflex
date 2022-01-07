# frozen_string_literal: true

class TaskBoardRepository < ApplicationRepository
  def all(args, params, order_by, direction)
    query = TaskBoard.where(organisation: organisation, project: project).where(args)
    query = query.where("lower(name) LIKE :keyword", keyword: "%#{params[:keywords].downcase}%") if params && params[:keywords].present?
    query = query.where(is_active: params[:is_active]) if params && params[:is_active].present?

    query.order(order_by => direction)
  end

  def create(params)
    task_board = TaskBoard.new(params)
    task_board.organisation = organisation
    task_board.project = project
    task_board.owner = user
    task_board.save
    task_board
  end

  def update(id, params)
    task_board = TaskBoard.find_by(id: id, organisation: organisation, project: project)
    task_board&.update(params)
    task_board
  end

  def load(id)
    TaskBoard.find_by(id: id, organisation: organisation, project: project)
  end
end
