class ProjectItemsController < ApplicationController
  include Pundit
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def create
    project_item = ProjectItems::CreateService.new.create_project_item create_params, current_user

    if project_item.valid?
      project_item.save
      ComputeProjectStatsJob.perform_later project_item.project_id.to_s
      WriteSystemLogJob.perform_later project_item._id.to_s, :created, current_user.full_name, nil
      redirect_to project_project_item_path(project_item.project, project_item)
    end
  end

  def destroy
    project_item = ProjectItem.find destroy_params[:id]
    authorize project_item

    project = Project.find destroy_params[:project_id]
    project_item.destroy
    flash[:success] = "#{project_item.class.type_name} was deleted"
    redirect_to project
  end

  def show
    @project_item = ProjectItem.find(params[:id]).decorate
    authorize @project_item
    @project = Project.find @project_item.project_id
    @state_buttons = GetStateButtonsService.new.get_values @project_item.state
    @comments = CommentDecorator.decorate_collection @project_item.comments.order_by(:created_at => 'desc'), context: { owner_id: @project_item.created_by_id }
  end

  def change_state
    ProjectItems::ChangeStateService.new.change change_state_params[:project_item_id], change_state_params[:state]

    redirect_to request.referrer
  end

  private

  def create_params
    params.permit(:title, :project_id, :commit)
  end

  def destroy_params
    params.permit(:project_id, :id)
  end

  def change_state_params
    params.permit(:state, :project_item_id, :project_id)
  end

  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_to(request.referrer || root_path)
  end

end
