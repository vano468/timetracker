class CreateRecords < ActiveRecord::Migration
  def change
    create_table :records do |t|
      t.string :type
      t.text :comment
      t.text :emails
      t.datetime :date_from
      t.datetime :date_to

      t.timestamps null: false
    end
  end
end
