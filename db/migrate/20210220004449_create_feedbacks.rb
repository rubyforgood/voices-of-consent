class CreateFeedbacks < ActiveRecord::Migration[5.2]
  def change
    create_table :feedbacks do |t|
      t.text :feedback
      t.string :category
      t.string :type

      t.timestamps
    end
  end
end
