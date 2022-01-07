# frozen_string_literal: true

class IssueRepository < ApplicationRepository
  def all(args, params, order_by, direction)
    query = Issue.with_rich_text_description.eager_load(:owner).where(organisation: organisation, project: project).where(args)
    query = query.where("cast(issues.id as varchar) LIKE :keyword OR lower(title) LIKE :keyword OR lower(reference) LIKE :keyword", keyword: "%#{params[:keywords].downcase}%") if params && params[:keywords].present?
    query = query.where(is_archived: params[:is_archived]) if params && params[:is_archived].present?

    query.order(build_order_by(order_by) => direction)
  end

  def create(params)
    issue = Issue.new(params)
    issue.organisation = organisation
    issue.project = project
    issue.owner = user if issue.owner.nil?
    issue.save
    issue
  end

  def update(id, params)
    issue = Issue.find_by(id: id, organisation: organisation, project: project)
    issue&.update(params)
    issue
  end

  def load(id)
    Issue.find_by(id: id, organisation: organisation, project: project)
  end

  private

  def build_order_by(order_by)
    case order_by
    when "owner"
      "users.last_name"
    else
      order_by
    end
  end
end
