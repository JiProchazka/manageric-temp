class ProjectItemPolicy < ApplicationPolicy
  attr_reader :user, :project_item

  def initialize(user, project_item)
    @user = user
    @project_item = project_item
  end

  def show?
    project = Project.where(_id: @project_item.project_id).first
    project.authorization.owner == user || project.authorization.users.include?(user)
  end

  def destroy?
    project = Project.where(_id: @project_item.project_id).first
    project.authorization.owner == user
  end
end
