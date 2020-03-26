# frozen_string_literal: true

json.array! @inventory_adjustments,
            partial: 'inventory_adjustments/inventory_adjustment',
            as: :inventory_adjustment
