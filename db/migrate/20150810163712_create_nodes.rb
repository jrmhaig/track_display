class CreateNodes < ActiveRecord::Migration
  def change
    create_table :nodes do |t|
      t.integer :track_id
      t.datetime :time
      t.float :lat
      t.float :long
      t.float :alt

      t.timestamps null: false
    end
  end
end
