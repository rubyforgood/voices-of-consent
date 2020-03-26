# frozen_string_literal: true

class AddReviewerIdToBoxRequests < ActiveRecord::Migration[5.2]
  def change
    add_reference :box_requests, :reviewed_by, foreign_key: { to_table: :users }
  end
end
