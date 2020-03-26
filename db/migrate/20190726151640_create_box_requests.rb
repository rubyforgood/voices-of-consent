# frozen_string_literal: true

class CreateBoxRequests < ActiveRecord::Migration[5.2]
  def change
    create_table :box_requests do |t|
      t.text :summary
      t.text :question_re_current_situation
      t.text :question_re_affect
      t.text :question_re_referral_source
      t.text :question_re_if_not_self_completed

      t.timestamps
    end
  end
end
