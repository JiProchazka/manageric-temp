module Projects
  class ComputeStatsService

    def get_total_stats projects
      stats = { total: 0,
        open: 0,
        percentage: 0,
        bugs: 0,
        user_stories: 0,
        improvements: 0,
        bugs_percentage: 0,
        user_stories_percentage: 0,
        improvements_percentage: 0 }

      projects.each do |p|
        stats[:total] += p.stats.items_count
        stats[:open] += p.stats.items_open
        stats[:bugs] += p.stats.open_bugs
        stats[:user_stories] += p.stats.open_user_stories
        stats[:improvements] += p.stats.open_improvements
      end

      stats[:bugs_percentage] = compute_percentage bugs, total
      stats[:user_stories_percentage] = compute_percentage user_stories, total
      stats[:improvements_percentage] = compute_percentage improvements, total
      stats[:percentage] = compute_percentage open, total
      stats
    end

    private

    def compute_percentage items_count, total
      100 - (items_count.to_f / total.to_f * 100).to_i
    end

  end
end
