class Comment
  include Mongoid::Document

  embedded_in :project_item

  field :created_at,      type: DateTime
  field :content,         type: String
  field :created_by,      type: String
  field :created_by_id,   type: BSON::ObjectId
end
