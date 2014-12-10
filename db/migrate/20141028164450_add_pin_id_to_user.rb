class AddPinIdToUser < ActiveRecord::Migration
  def change
    add_column :users, :pin_id, :integer
  end
end
