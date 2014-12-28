class AddByeToLeagues < ActiveRecord::Migration
  def change
    add_column :leagues, :bye, :boolean, default: false
  end
end
