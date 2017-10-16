class Improvement < ProjectItem
  include Mongoid::Document

  # for Pundit
  def self.policy_class
    ProjectItemPolicy
  end

  def self.code_prefix
    'I'
  end

  def self.color_css
    "bg-success"
  end

  def self.type_name
    "Improvement"
  end
end
