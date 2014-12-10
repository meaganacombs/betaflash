class RemoveCommentFromPin < ActiveRecord::Migration
  def change
    remove_column :pins, :comment, :text
  end
end
