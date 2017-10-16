class Api::UsersController < Api::ApiController

  before_action :restrict_access

  def add_to_project
    Projects::AddUserToProjectService.new.add permit_params[:user], permit_params[:project]
    respond_to do |format|
      format.json {
        render status: 200, json: nil
      }
    end
  end

  def get_for_project
    project = Project.find(params[:id])
    respond_to do |format|
      format.json {
        render json: { users: project.authorization.users, owner: project.authorization.owner }
      }
    end
  end

  def remove_from_project
    Projects::RemoveUserFromProjectService.new.remove permit_params[:project], permit_params[:user]
    respond_to do |format|
      format.json {
        render status: 200, json: nil
      }
    end
  end

  def search
    users = User.find_by_full_name_or_user_name params[:term]
    respond_to do |format|
      format.json {
        render json: users
      }
    end
  end

  private

  def permit_params
    params.permit(:user, :project, :value)
  end
end
