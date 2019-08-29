class InventoryAdjustment < ApplicationRecord
  belongs_to :inventory_tally
  belongs_to :purchase, optional: true
  belongs_to :box_item, optional: true

  validates :inventory_tally, presence: true

  before_save :adjust_cached_inventory_quantity

  def adjust_cached_inventory_quantity
    self.tally_quantity_start = self.inventory_tally.cached_quantity.to_i
    self.tally_quantity_end = self.tally_quantity_start + self.adjustment_quantity.to_i

    # TODO: need to decide how to handle self.tally_quantity_end < 0
    self.inventory_tally.update_attribute(:cached_quantity, self.tally_quantity_end)
  end
end
