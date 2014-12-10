class RemovePinsVisitedFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :pins_visited, :string
  end
end
