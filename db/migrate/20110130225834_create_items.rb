class CreateItems < ActiveRecord::Migration
  def self.up
    create_table :items do |t|
      t.string  :name
      t.integer :sport_id
      t.integer :place_id

      t.timestamps
    end
  end

  def self.down
    drop_table :items
  end
end
