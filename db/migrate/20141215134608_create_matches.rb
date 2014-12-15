class CreateMatches < ActiveRecord::Migration
  def change
    create_table :matches do |t|
      t.date :date
      t.integer :player_1_frames
      t.integer :player_2_frames

      t.timestamps
    end
  end
end
