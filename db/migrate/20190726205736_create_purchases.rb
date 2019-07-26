class CreatePurchases < ActiveRecord::Migration[5.2]
  def change
    create_table :purchases do |t|
      t.references :location, foreign_key: true
      t.float :total_price
      t.references :purchased_by, foreign_key: true
      t.references :reimbursed_by, foreign_key: true
      t.string :reimbursement_check_number
      t.string :reimbursement_status

      t.timestamps
    end
  end
end
