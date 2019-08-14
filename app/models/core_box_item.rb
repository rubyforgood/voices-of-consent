class CoreBoxItem < ApplicationRecord
  belongs_to :abuse_type
  belongs_to :inventory_type

  has_many_attached :file_uploads
end
