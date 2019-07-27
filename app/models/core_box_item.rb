class CoreBoxItem < ApplicationRecord
  has_many_attached :file_uploads
  belongs_to :abuse_type
  belongs_to :inventory_type
end
