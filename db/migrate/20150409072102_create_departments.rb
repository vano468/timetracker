class CreateDepartments < ActiveRecord::Migration
  def change
    create_table :departments do |t|
      t.string :title
      t.integer :boss_id, index: true
      t.integer :parent_id, index: true
      t.timestamps null: false
    end
  end
end
