class AddUserToRecords < ActiveRecord::Migration
  def change
    add_reference :records, :user, index: true
    add_foreign_key :records, :users
  end
end
