class AddPlayerRefToBreaks < ActiveRecord::Migration
  def change
    add_reference :breaks, :player, index: true
  end
end
