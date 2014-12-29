class AddForIndexToMatches < ActiveRecord::Migration
  def change
    add_column :matches, :player_1_id, :integer
    add_column :matches, :player_2_id, :integer
  end
end
