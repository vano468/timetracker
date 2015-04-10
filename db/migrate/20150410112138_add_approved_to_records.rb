class AddApprovedToRecords < ActiveRecord::Migration
  def change
    add_column :records, :boss_approved, :boolean
    add_column :records, :bookkeeper_approved, :boolean
  end
end
