class UserStory < ProjectItem
  include Mongoid::Document

  # for Pundit
  def self.policy_class
    ProjectItemPolicy
  end

  def self.code_prefix
    'U'
  end

  def self.color_css
    "bg-primary"
  end

  def self.type_name
    "User Story"
  end
end
