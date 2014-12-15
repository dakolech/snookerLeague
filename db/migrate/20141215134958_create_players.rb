class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.string :firstname
      t.string :lastname
      t.date :date_of_birth
      t.string :email
      t.integer :phone_number
      t.integer :max_break
      t.string :city

      t.timestamps
    end
  end
end
