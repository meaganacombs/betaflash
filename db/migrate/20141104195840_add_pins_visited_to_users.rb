class AddPinsVisitedToUsers < ActiveRecord::Migration
  def change
    add_column :users, :pins_visited, :string, :default => 0
  end
end
