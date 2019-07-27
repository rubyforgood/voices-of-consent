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

ActiveRecord::Schema.define(version: 2019_07_26_205736) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "box_requests", force: :cascade do |t|
    t.text "summary"
    t.text "question_re_current_situation"
    t.text "question_re_affect"
    t.text "question_re_referral_source"
    t.text "question_re_if_not_self_completed"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "requester_id"
    t.index ["requester_id"], name: "index_box_requests_on_requester_id"
  end

  create_table "boxes", force: :cascade do |t|
    t.bigint "box_request_id", null: false
    t.bigint "designed_by_id"
    t.bigint "design_reviewed_by_id"
    t.bigint "assembled_by_id"
    t.bigint "shipped_by_id"
    t.bigint "shipping_payment_id"
    t.datetime "shipped_at"
    t.string "shipment_tracking_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["assembled_by_id"], name: "index_boxes_on_assembled_by_id"
    t.index ["box_request_id"], name: "index_boxes_on_box_request_id"
    t.index ["design_reviewed_by_id"], name: "index_boxes_on_design_reviewed_by_id"
    t.index ["designed_by_id"], name: "index_boxes_on_designed_by_id"
    t.index ["shipped_by_id"], name: "index_boxes_on_shipped_by_id"
    t.index ["shipping_payment_id"], name: "index_boxes_on_shipping_payment_id"
  end

  create_table "inventory_tallies", force: :cascade do |t|
    t.string "additional_location_info"
    t.integer "cached_quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "inventory_types", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "locations", force: :cascade do |t|
    t.string "name"
    t.string "street_address"
    t.string "city"
    t.string "state"
    t.string "zip"
    t.integer "type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "meeting_types", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "meetings", force: :cascade do |t|
    t.bigint "meeting_type_id"
    t.string "title"
    t.bigint "location_id"
    t.datetime "start_time"
    t.datetime "end_time"
    t.boolean "tenative", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["location_id"], name: "index_meetings_on_location_id"
    t.index ["meeting_type_id"], name: "index_meetings_on_meeting_type_id"
  end

  create_table "purchases", force: :cascade do |t|
    t.bigint "location_id"
    t.float "total_price"
    t.bigint "purchased_by_id"
    t.bigint "reimbursed_by_id"
    t.string "reimbursement_check_number"
    t.string "reimbursement_status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["location_id"], name: "index_purchases_on_location_id"
    t.index ["purchased_by_id"], name: "index_purchases_on_purchased_by_id"
    t.index ["reimbursed_by_id"], name: "index_purchases_on_reimbursed_by_id"
  end

  create_table "requesters", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.string "street_address"
    t.string "city"
    t.string "state"
    t.string "zip"
    t.string "county"
    t.string "phone"
    t.boolean "ok_to_email"
    t.boolean "ok_to_text"
    t.boolean "ok_to_call"
    t.boolean "ok_to_mail"
    t.boolean "underage"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "taggings", id: :serial, force: :cascade do |t|
    t.integer "tag_id"
    t.string "taggable_type"
    t.integer "taggable_id"
    t.string "tagger_type"
    t.integer "tagger_id"
    t.string "context", limit: 128
    t.datetime "created_at"
    t.index ["context"], name: "index_taggings_on_context"
    t.index ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true
    t.index ["tag_id"], name: "index_taggings_on_tag_id"
    t.index ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context"
    t.index ["taggable_id", "taggable_type", "tagger_id", "context"], name: "taggings_idy"
    t.index ["taggable_id"], name: "index_taggings_on_taggable_id"
    t.index ["taggable_type"], name: "index_taggings_on_taggable_type"
    t.index ["tagger_id", "tagger_type"], name: "index_taggings_on_tagger_id_and_tagger_type"
    t.index ["tagger_id"], name: "index_taggings_on_tagger_id"
  end

  create_table "tags", id: :serial, force: :cascade do |t|
    t.string "name"
    t.integer "taggings_count", default: 0
    t.index ["name"], name: "index_tags_on_name", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "volunteers", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "street_address"
    t.string "city"
    t.string "state"
    t.integer "zip"
    t.string "county"
    t.string "phone"
    t.integer "university_location_id"
    t.integer "graduation_year"
    t.boolean "ok_to_email"
    t.boolean "ok_to_text"
    t.boolean "ok_to_call"
    t.boolean "ok_to_mail"
    t.boolean "underage"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "boxes", "box_requests"
  add_foreign_key "meetings", "locations"
  add_foreign_key "meetings", "meeting_types"
  add_foreign_key "purchases", "locations"
end
