class AddDateToEntries < ActiveRecord::Migration
  def change
    add_column :entries, :date, :datetime
  end
end
