class IssueComment < ApplicationRecord
  belongs_to :user
  belongs_to :issue

  has_rich_text :comment  
end
