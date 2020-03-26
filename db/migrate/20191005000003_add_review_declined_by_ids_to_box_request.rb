# frozen_string_literal: true

class AddReviewDeclinedByIdsToBoxRequest < ActiveRecord::Migration[5.2]
  def change
    add_column :box_requests,
               :review_declined_by_ids,
               :string,
               array: true, default: []
  end
end
