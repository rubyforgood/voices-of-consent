# frozen_string_literal: true

class BoxItem < ApplicationRecord
  belongs_to :box
  belongs_to :inventory_type
  belongs_to :researched_by,
             optional: true,
             class_name: 'User',
             foreign_key: :created_by_id,
             inverse_of: :box_items_as_researcher
  belongs_to :created_by,
             optional: true,
             class_name: 'User',
             foreign_key: :created_by_id,
             inverse_of: :box_items_as_creator
  belongs_to :updated_by,
             optional: true,
             class_name: 'User',
             foreign_key: :updated_by_id,
             inverse_of: :box_items_as_updater

  has_many_attached :file_uploads

  delegate :requires_research, to: :inventory_type

  def add_to_box!
    update(added_to_box: true)
  end
end
