class CreateRounds < ActiveRecord::Migration
  def change
    create_table :rounds do |t|
      t.date :start_date
      t.date :end_date
      t.integer :number

      t.timestamps
    end
  end
end
