# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include CableReady::Broadcaster
  include Pagy::Backend
  include SessionsHelper
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def user_in_organisation!
    return if current_user.current_organisation.present?

    first_membership = OrganisationMembership.find_by(user: current_user)
    current_user.update(current_organisation: first_membership.organisation) if first_membership.present?

    redirect_to new_organisation_path if current_user.current_organisation.nil?
  end

  def user_organisation_admin!
    organisation_membership ||= OrganisationMembership.find_by(user: current_user, organisation: current_organisation)
    admin_user = (current_user.id == current_organisation.owner_id) || organisation_membership&.is_admin
    return if admin_user

    redirect_to root_path
  end
  
  def user_selected_project!
    user_in_organisation!
    return if current_user.current_project.present?

    set_flash_message(:alert, "messages.no_project")

    redirect_to projects_path
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  end

  def pagy_results(results)
    pagy = nil
    page_count = (results.count / Pagy::VARS[:items].to_f).ceil

    page = (session[session_symbol("page")] || 1).to_i
    page = page_count if page > page_count
    pagy, paged_results = pagy(results, page: page) unless page_count.zero?
    paged_results = results if page_count.zero?

    return page, pagy, paged_results
  end

  def permitted_direction(direction)
    @direction = %w[asc desc].find { |permitted| direction == permitted } || "asc"
    @direction
  end

  def permitted_column_name(permitted_columns, column_name)
    @order_by = permitted_columns.find { |permitted| column_name == permitted } || permitted_columns.first
    @order_by
  end

  def query_params
    @query = session[session_symbol("query")]
    params[:keywords] = @query if @query
    params
  end

  def clear_searches(force = false)
    return unless force || session[:controller_name] != controller_name

    [:page, :query, :direction, :order_by].each { |k| session.delete(k) }
    session[:controller_name] = controller_name
  end

  def set_flash_message(key, kind, options = {})
    message = t(kind)
    if options[:now]
      flash.now[key] = message if message.present?
    elsif message.present?
      flash[key] = message
    end
  end
end
