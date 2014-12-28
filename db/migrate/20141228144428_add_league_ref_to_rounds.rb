class AddLeagueRefToRounds < ActiveRecord::Migration
  def change
    add_reference :rounds, :league, index: true
  end
end
