class AddActivityTypeToPins < ActiveRecord::Migration
  def change
    add_column :pins, :activity_type, :string
  end
end
