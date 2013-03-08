class AddKeeperToEntry < ActiveRecord::Migration
  def change
    add_column :entries, :keeper_id, :integer
  end
end
