class AddFrameRefToBreaks < ActiveRecord::Migration
  def change
    add_reference :breaks, :frame, index: true
  end
end
