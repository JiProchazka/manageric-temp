module Projects
  class AddUserToProjectService

    def add user_id, project_id
      user = User.find user_id
      project = Project.find project_id
      project.authorization.users << user
      project.save!
    end

  end
end
