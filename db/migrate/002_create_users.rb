class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.column :name,            :string, :limit => 20
      t.column :hashed_password, :string, :limit => 60
      t.column :salt,            :string
      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
