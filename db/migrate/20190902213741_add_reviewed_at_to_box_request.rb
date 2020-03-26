# frozen_string_literal: true

class AddReviewedAtToBoxRequest < ActiveRecord::Migration[5.2]
  def change
    add_column :box_requests, :reviewed_at, :datetime
  end
end
