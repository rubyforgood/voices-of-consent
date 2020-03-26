# frozen_string_literal: true

json.id box_item.id
json.inventory_type_id box_item.inventory_type_id
json.quantity box_item.quantity
json.inventory_type { json.name box_item.inventory_type.name }
