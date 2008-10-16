# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 4) do

  create_table "bookings", :force => true do |t|
    t.integer  "courier_id"
    t.datetime "booked_when"
    t.integer  "booked_by"
    t.string   "booked_for",      :limit => 80
    t.string   "destination",     :limit => 80
    t.string   "booking_ref",     :limit => 40
    t.string   "matter_number",   :limit => 12
    t.datetime "expected_pickup"
    t.integer  "despatched_by"
    t.datetime "despatched_when"
    t.string   "despatched_ref",  :limit => 50
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "couriers", :force => true do |t|
    t.string  "name",                  :limit => 50
    t.string  "account_no",            :limit => 10
    t.string  "contact",               :limit => 80
    t.string  "tel_description_1",     :limit => 30
    t.string  "tel_description_2",     :limit => 30
    t.string  "tel_description_3",     :limit => 30
    t.string  "tel_1",                 :limit => 30
    t.string  "tel_2",                 :limit => 30
    t.string  "tel_3",                 :limit => 30
    t.string  "auto_book_url"
    t.string  "auto_book_login"
    t.string  "auto_book_password"
    t.integer "auto_book_protocol_id"
  end

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :default => "", :null => false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "users", :force => true do |t|
    t.string   "name",            :limit => 20
    t.string   "hashed_password", :limit => 60
    t.string   "salt"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
