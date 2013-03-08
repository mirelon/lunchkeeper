class AddUserToKeeper < ActiveRecord::Migration
  def change
    add_column :keepers, :user_id, :integer
  end
end
