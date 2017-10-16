module Comments
  class UpdateContentService

    def update params
      project_item = ProjectItem.find params[:project_item_id]
      comment = project_item.comments.find params[:comment_id]
      comment.update(content: params[:content])
    end

  end
end
