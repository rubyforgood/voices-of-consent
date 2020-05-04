class InventoryType < ApplicationRecord
  has_many :box_items
  has_many :core_box_items
  has_many :inventory_tallies

  after_create :create_inventory_tallies

  private

  def create_inventory_tallies
    Location.all.each do |location|
      inventory_tallies.create(storage_location: location) if location.storage_unit?
    end
  end
end