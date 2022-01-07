# frozen_string_literal: true

class ApplicationRepository
  attr_accessor :organisation, :project, :user

  def initialize(user, organisation = nil, project = nil)
    @organisation = organisation || user.current_organisation
    @project = project || user.current_project
    @user = user
  end
end
