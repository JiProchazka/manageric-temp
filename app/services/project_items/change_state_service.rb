module ProjectItems
  class ChangeStateService

    def change id, state
      project_item = ProjectItem.find id
      project_item.public_send "#{state}!"
      project_item.save!

      Projects::ComputeStatsJob.perform_later project_item.project_id.to_s
      WriteSystemLogJob.perform_later project_item._id.to_s, :change_state, current_user.full_name, state.labelize
    end

  end
end
