class AddDiffToTables < ActiveRecord::Migration
  def change
    add_column :tables, :diff_small_points, :integer
  end
end
