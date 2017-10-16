class CommentDecorator < Draper::Decorator
  delegate_all

  def author_badge
    if object.created_by_id == helpers.current_user._id
      return helpers.content_tag(:label, "me", class: ["label", "bg-success", "m-l-xs"])
    elsif object.created_by_id == context[:owner_id]
      return helpers.content_tag(:label, "owner", class: ["label", "bg-info", "m-l-xs"])
    end
  end

end
