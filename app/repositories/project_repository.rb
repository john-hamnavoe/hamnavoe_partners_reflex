# frozen_string_literal: true

class ProjectRepository < ApplicationRepository
  def all(args, params, order_by, direction)
    query = Project.where(organisation: organisation).where(args)
    query = query.where("lower(name) LIKE :keyword", keyword: "%#{params[:keywords].downcase}%") if params && params[:keywords].present?
    query = query.where(is_active: params[:is_active]) if params && params[:is_active].present?

    query.order(order_by => direction)
  end

  def create(params)
    project = Project.new(params)
    project.organisation = organisation
    project.owner = user
    project.save
    project
  end

  def update(id, params)
    project = Project.find_by(id: id, organisation: organisation)
    project&.update(params)
    project
  end

  def load(id)
    Project.find_by(id: id, organisation: organisation)
  end
end
