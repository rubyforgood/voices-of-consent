class CreatePurchases < ActiveRecord::Migration[5.2]
  def change
    create_table :purchases do |t|
      t.references :location, foreign_key: true, null: true, index: true
      t.float :total_price
      t.references :purchased_by
      t.references :reimbursed_by
      t.string :reimbursement_check_number
      t.string :reimbursement_status

      t.timestamps
    end
  end
end
