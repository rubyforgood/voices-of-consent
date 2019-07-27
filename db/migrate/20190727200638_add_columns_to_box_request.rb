class AddColumnsToBoxRequest < ActiveRecord::Migration[5.2]
  def change
    add_column :box_requests, :is_interested_in_counseling_services, :boolean
    add_column :box_requests, :is_interested_in_health_services, :boolean
    add_column :box_requests, :is_safe, :boolean
  end
end
