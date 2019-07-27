class CoreBoxItem < ApplicationRecord
  belongs_to :abuse_type
  belongs_to :inventory_type
end
