module ProjectItems
  class CreateService
    def create_project_item params, current_user
      project = Project.find params[:project_id]
      type = params[:commit].delete(' ').constantize
      project_item = type.new
      project_item.title = params[:title]
      project_item.project = project
      project_item.not_started!
      project_item.code = create_code type, params[:project_id]
      project_item.created_at = Time.zone.now
      project_item.created_by = current_user.full_name
      project_item.created_by_id = current_user._id
      project_item
    end

    private

    def create_code type, project_id
      project = Project.find project_id
      "#{type.code_prefix}#{type.where(project_id: project._id).count + 1}"
    end
  end
end
