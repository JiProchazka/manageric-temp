class ProjectAuthorization
  include Mongoid::Document

  embedded_in             :project
  belongs_to              :owner,   class_name: "User", inverse_of: :projects_as_owner
  has_and_belongs_to_many :users,   class_name: "User"
end
