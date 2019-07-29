class CreateBoxRequestAbuseTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :box_request_abuse_types do |t|
      t.references :box_request, foreign_key: true
      t.references :abuse_type, foreign_key: true

      t.timestamps
    end
  end
end
