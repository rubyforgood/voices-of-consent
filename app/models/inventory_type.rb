# frozen_string_literal: true

class InventoryType < ApplicationRecord
  has_many :box_items
  has_many :core_box_items
  has_many :inventory_tallies
end
