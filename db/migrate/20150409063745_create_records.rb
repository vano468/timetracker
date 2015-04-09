class CreateRecords < ActiveRecord::Migration
  def change
    create_table :records do |t|
      t.integer :category
      t.datetime :date_from
      t.datetime :date_to
      t.string :emails

      t.timestamps null: false
    end
  end
end
