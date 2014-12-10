class AddUsersVisitedToPins < ActiveRecord::Migration
  def change
    add_column :pins, :users_visited, :string
  end
end
