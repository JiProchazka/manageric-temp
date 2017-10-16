class HomeController < ApplicationController
  before_action :authenticate

  def index
    redirect_to dashboard_path
  end

  def dashboard
    @projects = Project.for_user current_user
    @new_project = Project.new
    @total_stats = Projects::ComputeStatsService.new.get_total_stats @projects
  end
end
