class CreateLabels < ActiveRecord::Migration[6.0]
  def change
    create_table :labels do |t|
      t.string :genre, null: false

      t.timestamps
    end
  end
end
