class RemovePinIdFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :pin_id, :integer
  end
end
