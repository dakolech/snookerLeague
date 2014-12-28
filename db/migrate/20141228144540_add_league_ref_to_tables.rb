class AddLeagueRefToTables < ActiveRecord::Migration
  def change
    add_reference :tables, :league, index: true
  end
end
