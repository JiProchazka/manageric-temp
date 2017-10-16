class ProjectItemDecorator < Draper::Decorator
  delegate_all

  def full_title
    "#{object.type_name} '#{object.code}' - #{object.state.to_s.humanize}"
  end

  def project_item_type_css
    object.class.color_css
  end

end
