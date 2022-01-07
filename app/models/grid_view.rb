# frozen_string_literal: true

class GridView < ApplicationRecord
  belongs_to :grid
  belongs_to :user

  has_many :grid_view_columns, dependent: :destroy

  accepts_nested_attributes_for :grid_view_columns

  scope :by_user, ->(user) { where(user_id: user.id) }  
end
