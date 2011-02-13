class CreateReservables < ActiveRecord::Migration
  def self.up
    create_table :reservables do |t|
      t.string  :rfc
      t.string  :label
      t.integer :minutes
      t.float   :price
      t.integer :item_id

      t.timestamps
    end
  end

  def self.down
    drop_table :reservables
  end
end
