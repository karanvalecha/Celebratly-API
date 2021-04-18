class CreateOccurrences < ActiveRecord::Migration[6.1]
  def change
    create_table :occurrences do |t|
      t.string :title
      t.references :event, null: false, foreign_key: true
      t.timestamp :expires_at
      t.text :note
      t.integer :final_video_id
      t.timestamp :start_at
      t.timestamp :end_at

      t.timestamps
    end
  end
end
