class CreateEntries < ActiveRecord::Migration
  def change
    create_table :entries do |t|
      t.integer :count
      t.string :code
      t.string :description
      t.boolean :preselected

      t.timestamps
    end
  end
end
