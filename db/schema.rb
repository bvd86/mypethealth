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

<<<<<<< HEAD
<<<<<<< HEAD
ActiveRecord::Schema.define(version: 2022_05_17_235524) do
=======
ActiveRecord::Schema.define(version: 2022_05_17_225032) do
>>>>>>> 127f499cf63c1016c50ae0a1de1531c377206a79
=======
ActiveRecord::Schema.define(version: 2022_05_17_235524) do
>>>>>>> fe596a402d28073c6cd5d767baa3b7f4df73a484

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

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
    t.string "vet_specialty"
    t.boolean "available"
    t.float "latitude"
    t.float "longitude"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "consultations", "pets"
  add_foreign_key "consultations", "users"
  add_foreign_key "feedbacks", "consultations"
  add_foreign_key "messages", "consultations"
  add_foreign_key "messages", "users"
  add_foreign_key "pets", "users"
  add_foreign_key "receipts", "consultations"
end
