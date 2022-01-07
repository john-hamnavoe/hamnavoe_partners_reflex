# frozen_string_literal: true

module SelectHelper
  def users_for_owner_select
    UserRepository.new(current_user).all.map { |user| [user.name.full, user.id] }
  end

  def colors_for_select
    %w[red yellow green blue indigo purple pink]
  end
end
