module ProjectItems
  class UpdateService

    def update id, field, value
      project_item = ProjectItem.find id
      project_item.update(field => value)
    end

  end
end
