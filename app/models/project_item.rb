require 'simple_enum/mongoid'

class ProjectItem
  include Mongoid::Document
  include Mongoid::Slug
  include SimpleEnum::Mongoid

  @@all_states = {not_started: 0, stopped: 10, in_progress: 20, done: 30, client_accepted: 40}

  belongs_to :project
  embeds_many :comments

  field :code,            type: String
  field :title,           type: String
  field :created_at,      type: DateTime
  field :description,     type: String
  field :created_by,      type: String
  field :created_by_id,   type: BSON::ObjectId
  as_enum :state, @@all_states
  slug :code

  validates :code, presence: true
  validates :title, presence: true, length: { minimum: 3 }

  def self.all_states
    @@all_states
  end

  def self.get_comment project_item_id, comment_id
    project_item = ProjectItem.find project_item_id
    project_item.comments.find comment_id
  end

  def type_name
    self.class.type_name
  end

end
