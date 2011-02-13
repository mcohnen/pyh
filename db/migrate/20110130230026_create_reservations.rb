  class CreateReservations < ActiveRecord::Migration
  def self.up
    create_table :reservations do |t|
      t.datetime  :start
      t.datetime  :end
      t.float     :price
      t.string    :status
      t.integer   :user_id
      t.integer   :item_id
      t.integer   :reservable_id

      t.timestamps
    end
  end

  def self.down
    drop_table :reservations
  end
end
