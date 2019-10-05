class BoxRequestAbuseType < ApplicationRecord
  belongs_to :box_request
  belongs_to :abuse_type

  def abuse_type_name
    abuse_type.name
  end
end
