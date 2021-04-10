class CreateEvents < ActiveRecord::Migration[6.1]
  def change
    drop_table :events, if_exists: true

    create_table :events do |t|
      t.string :name
      t.string :color
      t.references :creator, polymorphic: true
      t.string :occurence_rule
      t.boolean :system_generated
      t.date :start_date
      t.date :end_date

      t.timestamps
    end
  end
end
