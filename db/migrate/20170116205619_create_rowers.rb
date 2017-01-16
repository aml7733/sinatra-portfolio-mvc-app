class CreateRowers < ActiveRecord::Migration[5.0]
  def change
    create_table :rowers do |t|
      t.string :name
      t.integer :weight
      t.integer :power
      t.integer :boat_id
    end
  end
end
