class CreateFrames < ActiveRecord::Migration
  def change
    create_table :frames do |t|
      t.integer :player_1_points
      t.integer :player_2_points

      t.timestamps
    end
  end
end
