# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160906004646) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.string   "author_type"
    t.integer  "author_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree
  end

  create_table "azure_roles", force: :cascade do |t|
    t.string   "azure_gid"
    t.string   "name"
    t.text     "roles"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cards", force: :cascade do |t|
    t.string   "code"
    t.integer  "student_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "departments", force: :cascade do |t|
    t.string   "name"
    t.string   "code"
    t.boolean  "active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "memberships", force: :cascade do |t|
    t.string   "name"
    t.decimal  "price"
    t.date     "start_date"
    t.date     "end_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "payment_methods", force: :cascade do |t|
    t.string   "name"
    t.boolean  "enabled"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "payments", force: :cascade do |t|
    t.string   "payable_type"
    t.integer  "payable_id"
    t.integer  "payment_method_id"
    t.boolean  "refunded"
    t.integer  "student_id"
    t.integer  "user_id"
    t.text     "details"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  create_table "roles", force: :cascade do |t|
    t.string   "name"
    t.string   "resource_type"
    t.integer  "resource_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id", using: :btree
    t.index ["name"], name: "index_roles_on_name", using: :btree
  end

  create_table "students", force: :cascade do |t|
    t.string   "gender"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "student_id"
    t.integer  "department_id"
    t.integer  "study_year_id"
    t.string   "phone"
    t.date     "birthday"
    t.text     "details"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "study_years", force: :cascade do |t|
    t.string   "name"
    t.integer  "year"
    t.boolean  "active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "azure_token"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  create_table "users_roles", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "role_id"
    t.index ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id", using: :btree
  end

  create_table "wei_bungalows", force: :cascade do |t|
    t.integer  "wei_id"
    t.string   "name"
    t.integer  "seats"
    t.integer  "wei_bus_id"
    t.string   "gender"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "wei_registrations_count", default: 0
  end

  create_table "wei_buses", force: :cascade do |t|
    t.integer  "wei_id"
    t.string   "name"
    t.integer  "seats"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "wei_registrations_count", default: 0
  end

  create_table "wei_registrations", force: :cascade do |t|
    t.integer  "student_id"
    t.integer  "wei_id"
    t.integer  "wei_bungalow_id"
    t.integer  "wei_bus_id"
    t.string   "status"
    t.boolean  "paid"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "registration_by"
    t.boolean  "caution"
    t.text     "details"
    t.text     "medical_details"
    t.boolean  "parental"
  end

  create_table "weis", force: :cascade do |t|
    t.string   "name"
    t.boolean  "enabled"
    t.decimal  "price"
    t.integer  "seats"
    t.date     "date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
