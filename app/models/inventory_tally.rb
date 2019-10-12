class InventoryTally < ApplicationRecord
  belongs_to :inventory_type
  belongs_to :storage_location, class_name: "Location"

  has_many :inventory_adjustments

  has_many_attached :file_uploads
end
