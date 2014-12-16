class CreateTables < ActiveRecord::Migration
  def change
    create_table :tables do |t|
      t.integer :position
      t.integer :number_of_matches
      t.integer :points
      t.integer :number_of_wins
      t.integer :number_of_loss
      t.integer :number_of_win_frames
      t.integer :number_of_lose_frames
      t.integer :number_of_win_small_points
      t.integer :number_of_lose_small_points

      t.timestamps
    end
  end
end
