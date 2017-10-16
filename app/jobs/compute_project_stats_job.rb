class ComputeProjectStatsJob < ApplicationJob
  queue_as :manageric_project_stats

  def perform(project_id)
    project_id = BSON::ObjectId.from_string(project_id)
    project = Project.find project_id
    items = ProjectItem.where(project_id: project_id)

    if items.size > 0
      bugs = items.select { |i| i._type == Bug.type_name }
      user_stories = items.select { |i| i._type ==  UserStory.name }
      improvements = items.select { |i| i._type ==  Improvement.name }

      project.stats.tap do |pi|
        pi.items_count = items.size
        pi.bugs = bugs.size
        pi.user_stories = user_stories.size
        pi.improvements = improvements.size
        pi.open_bugs = bugs.select { |i| i.in_progress? || i.not_started? || i.stopped? }.size
        pi.open_user_stories = user_stories.select { |i| i.in_progress? || i.not_started? || i.stopped? }.size
        pi.open_improvements = improvements.select { |i| i.in_progress? || i.not_started? || i.stopped? }.size
        pi.items_open = pi.open_bugs + pi.open_user_stories + pi.open_improvements
        pi.percentage = 100 - (pi.items_open.to_f / pi.items_count.to_f * 100).to_i
      end
      project.save!
    end
  end
end
