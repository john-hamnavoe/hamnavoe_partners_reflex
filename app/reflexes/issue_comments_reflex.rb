# frozen_string_literal: true

class IssueCommentsReflex < CommentsReflex
  def post
    @commentable = Issue.find_by(id: element.dataset[:id])
    super
  end
end
