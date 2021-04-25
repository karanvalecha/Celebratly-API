class CreateStatusUploads < ActiveRecord::Migration[6.1]
  def change
    create_table :status_uploads do |t|
      t.string :media_type
      t.references :occurrence, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.text :url
      t.string :tag

      t.timestamps
    end
  end
end
