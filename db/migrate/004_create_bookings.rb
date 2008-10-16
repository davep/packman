class CreateBookings < ActiveRecord::Migration
  def self.up
    create_table :bookings do |t|
      t.column :courier_id,      :integer
      t.column :booked_when,     :datetime
      t.column :booked_by,       :integer
      t.column :booked_for,      :string, :limit => 80
      t.column :destination,     :string, :limit => 80
      t.column :booking_ref,     :string, :limit => 40
      t.column :matter_number,   :string, :limit => 12
      t.column :expected_pickup, :datetime
      t.column :despatched_by,   :integer
      t.column :despatched_when, :datetime
      t.column :despatched_ref,  :string, :limit => 50
      t.column :notes,           :text
      t.timestamps
    end
  end

  def self.down
    drop_table :bookings
  end
end
