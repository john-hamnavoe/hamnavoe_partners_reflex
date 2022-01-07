# frozen_string_literal: true

class Users::CurrentProjectsController < ApplicationController
  before_action :authenticate_user!
  before_action :user_in_organisation!

  def update
    project = repo.load(params[:id])
    current_user.update current_project: project if project
    redirect_to dashboard_index_path
  end

  protected

  def repo
    @repo ||= ProjectRepository.new(current_user)
  end
end
