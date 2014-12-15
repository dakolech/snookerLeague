class CreateBreaks < ActiveRecord::Migration
  def change
    create_table :breaks do |t|
      t.integer :points

      t.timestamps
    end
  end
end
