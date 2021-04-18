class RenameCreatorToReference < ActiveRecord::Migration[6.1]
  def change
    rename_column :events, :creator_type, :reference_type
    rename_column :events, :creator_id, :reference_id
  end
end
