# frozen_string_literal: true

class IssuesController < ApplicationController
  before_action :authenticate_user!
  before_action :user_in_organisation!
  before_action :user_selected_project!

  def show
    @issue = repo.load(params[:id])
  end

  def index
    @include_archived = session[:issue_include_archived] || false
    args = @include_archived ? {} : { is_archived: false }

    issues = repo.all(args, query_params, permitted_column_name(permitted_order_columns, session[session_symbol("order_by")]), permitted_direction(session[session_symbol("direction")]))
    @page, @pagy, @issues = pagy_results(issues)

    respond_to do |format|
      format.html
      format.json { render json: issues }
    end
  end

  def create
    @issue = repo.create(issue_params)
    if @issue.valid?
      redirect_to issues_path
    else
      respond_to do |format|
        format.html { broadcast_errors @issue, issue_params }
        format.json { render json: @issue.errors.to_json, status: :unprocessable_entity }
      end
    end
  end

  def update
    @issue = repo.update(params[:id], issue_params)
    render json: "Invalid", status: :unprocessable_entity and return unless @issue

    if @issue.valid?
      redirect_to issues_path
    else
      respond_to do |format|
        format.html { broadcast_errors @issue, issue_params }
        format.json { render json: @issue.errors.to_json, status: :unprocessable_entity }
      end
    end
  end

  private

  def issue_params
    params.require(:issue).permit(:title, :reference, :description, :is_archived, :owner_id, :color, :priority_id)
  end

  def permitted_order_columns
    %w[id title reference description owner priority_id]
  end

  def repo
    @repo ||= IssueRepository.new(current_user)
  end
end
