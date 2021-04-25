class AddCaptionToOccurrence < ActiveRecord::Migration[6.1]
  def change
    add_column :occurrences, :caption, :string
  end
end
