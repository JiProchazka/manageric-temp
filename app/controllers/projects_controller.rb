class ProjectsController < ApplicationController
  include Pundit
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  before_action :authenticate

  def create
    @project = Project.new create_permit
    authorize @project
    if @project.valid?
      @project.authorization = ProjectAuthorization.new({ owner: current_user })
      @project.save
      redirect_to @project
    else
      redirect_to action: "dashboard", controller: "home"
    end
  end

  def show
    @project = Project.find params[:id]
    authorize @project
    @project_items = ProjectItemDecorator.decorate_collection ProjectItem.where(project_id: @project._id)
  end

  private

  def create_permit
    params.require(:project).permit(:name, :customer, :info, :code)
  end

  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_to(request.referrer || root_path)
  end
end
