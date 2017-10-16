class ProjectPolicy < ApplicationPolicy
  attr_reader :user, :project

  def initialize(user, project)
    @user = user
    @project = project
  end

  def show?
    project.authorization.owner == user || project.authorization.users.include?(user)
  end

  def create?
    # !user.is_client
    true
  end
end
