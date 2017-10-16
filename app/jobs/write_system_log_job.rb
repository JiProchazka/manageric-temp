class WriteSystemLogJob < ApplicationJob
  queue_as :manageric_create_system_log

  def perform project_item_id, type, full_name, new_value
    SystemLog.new.tap do |sl|
      sl.project_item_id = project_item_id
      sl.user = full_name
      sl.new_value = new_value
      sl.type = type
      sl.save!
    end
  end
end
