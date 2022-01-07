# frozen_string_literal: true

class ProjectsController < ApplicationController
  before_action :authenticate_user!
  before_action :user_in_organisation!

  def index
    projects = repo.all({}, query_params, permitted_column_name(permitted_order_columns, session[session_symbol("order_by")]), permitted_direction(session[session_symbol("direction")]))
    @page, @pagy, @projects = pagy_results(projects)

    respond_to do |format|
      format.html
      format.json { render json: projects }
    end
  end

  def create
    @project = repo.create(project_params)
    if @project.valid?
      redirect_to projects_path
    else
      render "new"
    end
  end

  def update
    @project = repo.update(params[:id], project_params)
    render json: "Invalid", status: :unprocessable_entity and return unless @project

    if @project.valid?
      redirect_to projects_path
    else
      render "edit"
    end
  end

  def edit
    @project = repo.load(params[:id])
    set_flash_message(:notice, "messages.no_resource") unless @project
    redirect_to projects_path unless @project
  end

  def new
    @project = Project.new
  end

  private

  def project_params
    params.require(:project).permit(:name, :software, :version, :is_active, :start_date, :end_date)
  end

  def permitted_order_columns
    %w[name software version start_date end_date owner]
  end

  def repo
    @repo ||= ProjectRepository.new(current_user)
  end
end
