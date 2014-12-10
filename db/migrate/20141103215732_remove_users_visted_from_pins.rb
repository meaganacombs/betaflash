class RemoveUsersVistedFromPins < ActiveRecord::Migration
  def change
    remove_column :pins, :users_visited, :string
  end
end
