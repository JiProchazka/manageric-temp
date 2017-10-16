class SystemLog
  include Mongoid::Document
  include SimpleEnum::Mongoid

  belongs_to :project_item

  field :user, type: String
  field :new_value, type: String
  as_enum :type, {added_comment: 1, changed_state: 2, created: 3}

end
