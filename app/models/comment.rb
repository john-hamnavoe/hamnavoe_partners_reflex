class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :commentable, polymorphic: true
  belongs_to :parent, optional: true, class_name: "Comment"

  has_rich_text :body

  def comments
    Comment.eager_load([:rich_text_body, :user]).where(commentable: commentable, parent_id: id)
  end
end
