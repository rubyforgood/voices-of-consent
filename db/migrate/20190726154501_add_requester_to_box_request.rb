class AddRequesterToBoxRequest < ActiveRecord::Migration[5.2]
  def change
    add_column :box_requests, :requester_id, :integer
    add_index :box_requests, :requester_id
  end
end
