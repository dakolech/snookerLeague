class AddPlayerRefToTables < ActiveRecord::Migration
  def change
    add_reference :tables, :player, index: true
  end
end
