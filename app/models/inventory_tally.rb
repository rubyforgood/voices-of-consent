class InventoryTally < ApplicationRecord
  has_many_attached :file_uploads
  belongs_to :inventory_type
  belongs_to :storage_location, class_name: "Location"
end
