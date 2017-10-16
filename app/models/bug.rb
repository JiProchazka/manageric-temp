class Bug < ProjectItem
  include Mongoid::Document

  # for Pundit
  def self.policy_class
    ProjectItemPolicy
  end

  def self.code_prefix
    'B'
  end

  def self.color_css
    "bg-info"
  end

  def self.type_name
    "Bug"
  end
  
end
