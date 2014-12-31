class AddMatchRefToFrames < ActiveRecord::Migration
  def change
    add_reference :frames, :match, index: true
  end
end
