class CreateLeaguesPlayersJoinTable < ActiveRecord::Migration
  def change
    create_table :leagues_players, id: false do |t|
      t.belongs_to :league
      t.belongs_to :player
    end

    add_index :leagues_players, [:league_id, :player_id]
  end
end
