class Api::CommentsController < Api::ApiController

  before_action :restrict_access

  def save_content
    Comments::UpdateContentService.new.update permit_params
    respond_to do |format|
      format.json {
        render status: 200, json: nil
      }
    end
  end

  private

  def permit_params
    params.permit(:project_item_id, :comment_id, :content)
  end

end
