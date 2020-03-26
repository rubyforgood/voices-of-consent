# frozen_string_literal: true

class InventoryAdjustment < ApplicationRecord
  belongs_to :inventory_tally
  belongs_to :purchase, optional: true
  belongs_to :box_item, optional: true

  validates :inventory_tally, presence: true
end
