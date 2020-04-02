# frozen_string_literal: true

class Location < ApplicationRecord
  has_many :assembled_boxes,
           class_name: 'Box', foreign_key: 'assembly_location_id', inverse_of: :assembly_location
  has_many :inventory_tallies, foreign_key: :storage_location_id
  has_many :meetings
  has_many :purchases
  has_many :volunteers, foreign_key: 'university_location_id', dependent: :nullify

  validates :name, presence: true
  validates :location_type, presence: true

  after_create :create_inventory_tallies, if: :storage_unit?

  enum location_type: {
    # Example types from ERD
    # Can't call it `store` because it's an AR method
    storage_unit: 0,
    shop: 1,
    meeting_space: 2,
    video_chat_link: 3,
    distribution_partner: 4,
    university: 5
  }

  private

  def create_inventory_tallies
    InventoryType.all.each do |inventory_type|
      inventory_tallies.create(inventory_type: inventory_type)
    end
  end
end
