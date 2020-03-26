# frozen_string_literal: true

json.array! @box_items, partial: 'box_items/box_item', as: :box_item
