class CreateMemos < ActiveRecord::Migration[6.0]
  def change
    create_table :memos do |t|
      t.references :task_item, null: false, foreign_key: true
      t.text :content, null: false

      t.timestamps
    end
  end
end
