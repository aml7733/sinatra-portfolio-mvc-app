class CreateBoats < ActiveRecord::Migration[5.0]
  def change
    create_table :boats do |t|
      t.string :name
      t.integer :num_seats
      t.integer :weight
      t.integer :coach_id
    end
  end
end
