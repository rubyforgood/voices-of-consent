# frozen_string_literal: true

json.array! @inventory_tallies,
            partial: 'inventory_tallies/inventory_tally', as: :inventory_tally
