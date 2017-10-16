class CommentsController < ApplicationController

  def create
    Comments::CreateCommentService.new.create params, current_user
    redirect_to request.referrer
  end

  def destroy
    comment = ProjectItem.get_comment destroy_params[:project_item_id], destroy_params[:id]
    comment.delete
    redirect_to request.referrer
  end

  private

  def destroy_params
    params.permit(:project_item_id, :id)
  end

end
