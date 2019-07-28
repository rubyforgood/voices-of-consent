json.extract! inventory_adjustment, :id, :inventory_tally_id, :purchase_id, :box_item_id, :total_cost, :tally_quantity_start, :tally_quantity_end, :adjustment_quantity, :created_at, :updated_at
json.url inventory_adjustment_url(inventory_adjustment, format: :json)
