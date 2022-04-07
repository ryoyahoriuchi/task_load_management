class CreateTaskItems < ActiveRecord::Migration[6.0]
  def change
    create_table :task_items do |t|
      t.string :item
      t.integer :level
      t.references :task, null: false, foreign_key: true

      t.timestamps
    end
  end
end
