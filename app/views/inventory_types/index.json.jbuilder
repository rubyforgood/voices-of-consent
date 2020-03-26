# frozen_string_literal: true

json.array! @inventory_types,
            partial: 'inventory_types/inventory_type', as: :inventory_type
