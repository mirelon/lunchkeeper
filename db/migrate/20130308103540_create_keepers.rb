class CreateKeepers < ActiveRecord::Migration
  def change
    create_table :keepers do |t|
      t.string :name

      t.timestamps
    end
  end
end
