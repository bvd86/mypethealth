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

ActiveRecord::Schema.define(version: 2022_05_27_000348) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "consultations", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "pet_id", null: false
    t.string "concern_category"
    t.text "additional_info"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["pet_id"], name: "index_consultations_on_pet_id"
    t.index ["user_id"], name: "index_consultations_on_user_id"
  end

  create_table "feedbacks", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "consultation_id", null: false
    t.integer "rating"
    t.text "comment"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["consultation_id"], name: "index_feedbacks_on_consultation_id"
    t.index ["user_id"], name: "index_feedbacks_on_user_id"
  end

  create_table "messages", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "consultation_id", null: false
    t.string "content"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["consultation_id"], name: "index_messages_on_consultation_id"
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "pets", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "name"
    t.string "species"
    t.string "breed"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_pets_on_user_id"
  end

  create_table "receipts", force: :cascade do |t|
    t.bigint "consultation_id", null: false
    t.integer "price_cents"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["consultation_id"], name: "index_receipts_on_consultation_id"
  end

  create_table "specialties", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "user_specialties", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "specialty_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["specialty_id"], name: "index_user_specialties_on_specialty_id"
    t.index ["user_id"], name: "index_user_specialties_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "name"
    t.string "address"
    t.boolean "available"
    t.float "latitude"
    t.float "longitude"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "consultations", "pets"
  add_foreign_key "consultations", "users"
  add_foreign_key "feedbacks", "consultations"
  add_foreign_key "messages", "consultations"
  add_foreign_key "messages", "users"
  add_foreign_key "pets", "users"
  add_foreign_key "receipts", "consultations"
  add_foreign_key "user_specialties", "specialties"
  add_foreign_key "user_specialties", "users"
end
