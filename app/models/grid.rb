# frozen_string_literal: true

class Grid < ApplicationRecord
  has_many :columns, dependent: :destroy
  has_many :grid_views, dependent: :destroy
end
