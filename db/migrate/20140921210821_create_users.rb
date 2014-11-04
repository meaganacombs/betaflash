class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.text :pins_visited, array: true, default: []
      
      t.timestamps
    end
  end
end
