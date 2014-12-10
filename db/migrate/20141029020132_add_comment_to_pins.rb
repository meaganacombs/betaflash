class AddCommentToPins < ActiveRecord::Migration
  def change
    add_column :pins, :comment, :text
  end
end
