module Comments
  class CreateCommentService

    def create params, current_user
      project_item = ProjectItem.find params.permit(:project_item_id)[:project_item_id]
      project_item.comments.create(
        { content: params.require(:comment).permit(:content)[:content],
          created_at: Time.zone.now,
          created_by: current_user.full_name,
          created_by_id: current_user._id
        }
      )
      project_item.save!

      WriteSystemLogJob.perform_later project_item._id.to_s, :added_comment, current_user.full_name, nil
    end

  end
end
