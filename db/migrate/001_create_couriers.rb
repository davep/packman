class CreateCouriers < ActiveRecord::Migration
  def self.up
    create_table :couriers do |t|
      t.column :name,                  :string, :limit => 50
      t.column :account_no,            :string, :limit => 10
      t.column :contact,               :string, :limit => 80
      t.column :tel_description_1,     :string, :limit => 30
      t.column :tel_description_2,     :string, :limit => 30
      t.column :tel_description_3,     :string, :limit => 30
      t.column :tel_1,                 :string, :limit => 30
      t.column :tel_2,                 :string, :limit => 30
      t.column :tel_3,                 :string, :limit => 30
      t.column :auto_book_url,         :string
      t.column :auto_book_login,       :string
      t.column :auto_book_password,    :string
      t.column :auto_book_protocol_id, :integer
    end
  end

  def self.down
    drop_table :couriers
  end
end
