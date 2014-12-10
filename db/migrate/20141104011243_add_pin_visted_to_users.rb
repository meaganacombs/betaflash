class AddPinVistedToUsers < ActiveRecord::Migration
  def change
    add_column :users, :pins_visited, :string
  end
end
