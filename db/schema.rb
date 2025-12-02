# frozen_string_literal: true

# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2024_01_01_000002) do
  create_table 'items', force: :cascade do |t|
    t.string 'name', null: false
    t.text 'description'
    t.decimal 'price', precision: 10, scale: 2, default: '0.0', null: false
    t.integer 'quantity', default: 0, null: false
    t.boolean 'published', default: false
    t.boolean 'featured', default: false
    t.datetime 'published_at'
    t.integer 'user_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['featured'], name: 'index_items_on_featured'
    t.index ['name'], name: 'index_items_on_name'
    t.index ['published'], name: 'index_items_on_published'
    t.index ['user_id'], name: 'index_items_on_user_id'
  end

  create_table 'users', force: :cascade do |t|
    t.string 'name', null: false
    t.string 'email', null: false
    t.string 'password_digest', null: false
    t.boolean 'admin', default: false
    t.boolean 'active', default: true
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['email'], name: 'index_users_on_email', unique: true
  end

  add_foreign_key 'items', 'users'
end
