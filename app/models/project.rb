class Project
  include Mongoid::Document
  include Mongoid::Slug

  after_initialize :init

  has_many :project_items
  embeds_one :authorization, class_name: "ProjectAuthorization"
  embeds_one :stats, class_name: "ProjectStats"

  field :name, type: String
  field :customer, type: String
  field :info, type: String

  validates :name, presence: true, length: { minimum: 3 }
  validates :customer, presence: true

  slug :generate_custom_slug

  def init
    self.stats ||= ProjectStats.new
  end

  def self.for_user(user)
    Project.where("$or" => [{'authorization.owner_id': user._id}, {'authorization.user_ids': user._id}])
  end

  private

  def generate_custom_slug
    "#{('a'..'z').to_a.shuffle[0,6].join}-#{name}"
  end
end
