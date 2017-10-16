class Api::ProjectItemsController < Api::ApiController

  before_action :restrict_access

  def save_description
    ProjectItems::UpdateService.new.update permit_params_for_description[:project], :description, permit_params_for_description[:description]
    respond_to do |format|
      format.json {
        render status: 200, json: nil
      }
    end
  end

  def save_title
    ProjectItems::UpdateService.new.update permit_params_for_title[:project], :title, permit_params_for_title[:title]
    respond_to do |format|
      format.json {
        render status: 200, json: nil
      }
    end
  end

  private

  def permit_params_for_description
    params.permit(:project, :description)
  end

  def permit_params_for_title
    params.permit(:project, :title)
  end

end
