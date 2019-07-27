json.extract! box, :id, :box_request_id, :designed_by_id, :design_reviewed_by_id, :assembled_by_id, :shipped_by_id, :shipping_payment_id, :shipped_at, :shipment_tracking_number, :created_at, :updated_at
json.url box_url(box, format: :json)
