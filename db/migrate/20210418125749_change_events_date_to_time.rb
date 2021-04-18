class ChangeEventsDateToTime < ActiveRecord::Migration[6.1]
  def change
    remove_column :events, :start_date
    remove_column :events, :end_date

    add_column :events, :start_at, :timestamp
    add_column :events, :end_at, :timestamp
  end
end
