class Issue < ApplicationRecord
  belongs_to :owner, class_name: "User"
  belongs_to :project
  belongs_to :organisation

  has_rich_text :description

  has_many :comments, as: :commentable, dependent: :destroy
end
