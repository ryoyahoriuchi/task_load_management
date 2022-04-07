class CreateTasks < ActiveRecord::Migration[6.0]
  def change
    create_table :tasks do |t|
      t.string :title
      t.string :overview
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
