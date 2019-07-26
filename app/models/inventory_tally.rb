class InventoryTally < ApplicationRecord
    belongs_to :inventory_type
    belongs_to :storage_location, class_name: "Location"
end
