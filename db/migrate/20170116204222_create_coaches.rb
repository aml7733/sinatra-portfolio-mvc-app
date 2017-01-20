class CreateCoaches < ActiveRecord::Migration[5.0]
  def change
    create_table :coaches do |t|
      t.string :name
      t.string :password_digest
      t.string :club_name
    end
  end
end
