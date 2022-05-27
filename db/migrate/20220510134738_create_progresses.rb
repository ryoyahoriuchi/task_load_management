class CreateProgresses < ActiveRecord::Migration[6.0]
  def change
    create_table :progresses do |t|
      # t.datetime :day
      t.integer :item_number
      t.integer :percent
      t.references :task, null: false, foreign_key: true

      t.timestamps
    end
  end
end
