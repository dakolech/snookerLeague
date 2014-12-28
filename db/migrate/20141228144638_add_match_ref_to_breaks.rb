class AddMatchRefToBreaks < ActiveRecord::Migration
  def change
    add_reference :breaks, :match, index: true
  end
end
