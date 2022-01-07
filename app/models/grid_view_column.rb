# frozen_string_literal: true

class GridViewColumn < ApplicationRecord
  acts_as_list scope: [:grid_view_id]
  belongs_to :grid_view
  belongs_to :column
end
