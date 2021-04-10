class AddColumnsToUsersTable < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :doj, :date
    add_column :users, :dob, :date
    add_column :users, :import_key, :string
    add_column :users, :full_name, :string
  end
end
