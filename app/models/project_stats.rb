class ProjectStats
  include Mongoid::Document

  embedded_in :project

  field :items_count,         type: Integer, default: 0
  field :items_open,          type: Integer, default: 0
  field :bugs,                type: Integer, default: 0
  field :user_stories,        type: Integer, default: 0
  field :improvements,        type: Integer, default: 0
  field :open_bugs,           type: Integer, default: 0
  field :open_user_stories,   type: Integer, default: 0
  field :open_improvements,   type: Integer, default: 0
  field :percentage,          type: Integer, default: 0
end
