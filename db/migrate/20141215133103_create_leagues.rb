class CreateLeagues < ActiveRecord::Migration
  def change
    create_table :leagues do |t|
      t.string :name
      t.date :start_date
      t.date :end_date
      t.integer :number_of_players
      t.integer :number_of_winners
      t.integer :number_of_dropots
      t.integer :best_of
      t.integer :win_points
      t.integer :loss_points

      t.timestamps
    end
  end
end
