class CreateEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :events do |t|
      t.date :start_time_on, null: false
      t.date :end_time_on, null: false
      t.references :task, null: false, foreign_key: true

      t.timestamps
    end
  end
end
