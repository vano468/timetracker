class RemoveCommentFromRecord < ActiveRecord::Migration
  def change
    remove_column :records, :comment, :text
  end
end
