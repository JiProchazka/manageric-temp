module Projects
  class RemoveUserFromProjectService

    def remove project_id, user_id
      project = Project.find project_id
      project.authorization.users.delete(User.find(id: user_id))
      project.save!
    end

  end
end
