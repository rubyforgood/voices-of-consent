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

ActiveRecord::Schema.define(version: 2019_10_06_173749) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "abuse_types", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_id"], name: "index_active_storage_attachments_on_record_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "attendances", force: :cascade do |t|
    t.bigint "meeting_id"
    t.bigint "user_id"
    t.string "special_duties"
    t.boolean "completed_hours"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["meeting_id"], name: "index_attendances_on_meeting_id"
    t.index ["user_id"], name: "index_attendances_on_user_id"
  end

  create_table "box_items", force: :cascade do |t|
    t.integer "box_id", null: false
    t.integer "researched_by_id"
    t.boolean "added_to_box"
    t.integer "created_by_id", null: false
    t.integer "updated_by_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "inventory_type_id", null: false
    t.index ["box_id"], name: "index_box_items_on_box_id"
    t.index ["created_by_id"], name: "index_box_items_on_created_by_id"
    t.index ["inventory_type_id"], name: "index_box_items_on_inventory_type_id"
    t.index ["researched_by_id"], name: "index_box_items_on_researched_by_id"
    t.index ["updated_by_id"], name: "index_box_items_on_updated_by_id"
  end

  create_table "box_request_abuse_types", force: :cascade do |t|
    t.bigint "box_request_id"
    t.bigint "abuse_type_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["abuse_type_id"], name: "index_box_request_abuse_types_on_abuse_type_id"
    t.index ["box_request_id"], name: "index_box_request_abuse_types_on_box_request_id"
  end

  create_table "box_requests", force: :cascade do |t|
    t.text "summary"
    t.text "question_re_current_situation"
    t.text "question_re_affect"
    t.text "question_re_referral_source"
    t.text "question_re_if_not_self_completed"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "requester_id"
    t.boolean "is_interested_in_counseling_services"
    t.boolean "is_interested_in_health_services"
    t.boolean "is_safe"
    t.bigint "reviewed_by_id"
    t.string "aasm_state"
    t.datetime "reviewed_at"
    t.string "review_declined_by_ids", default: [], array: true
    t.index ["requester_id"], name: "index_box_requests_on_requester_id"
    t.index ["reviewed_by_id"], name: "index_box_requests_on_reviewed_by_id"
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
    t.string "aasm_state"
    t.datetime "designed_at"
    t.index ["assembled_by_id"], name: "index_boxes_on_assembled_by_id"
    t.index ["box_request_id"], name: "index_boxes_on_box_request_id"
    t.index ["design_reviewed_by_id"], name: "index_boxes_on_design_reviewed_by_id"
    t.index ["designed_by_id"], name: "index_boxes_on_designed_by_id"
    t.index ["shipped_by_id"], name: "index_boxes_on_shipped_by_id"
    t.index ["shipping_payment_id"], name: "index_boxes_on_shipping_payment_id"
  end

  create_table "core_box_items", force: :cascade do |t|
    t.bigint "abuse_type_id", null: false
    t.bigint "inventory_type_id", null: false
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["abuse_type_id"], name: "index_core_box_items_on_abuse_type_id"
    t.index ["inventory_type_id"], name: "index_core_box_items_on_inventory_type_id"
  end

  create_table "inventory_adjustments", force: :cascade do |t|
    t.bigint "inventory_tally_id"
    t.bigint "purchase_id"
    t.bigint "box_item_id"
    t.integer "total_cost"
    t.integer "adjustment_quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["box_item_id"], name: "index_inventory_adjustments_on_box_item_id"
    t.index ["inventory_tally_id"], name: "index_inventory_adjustments_on_inventory_tally_id"
    t.index ["purchase_id"], name: "index_inventory_adjustments_on_purchase_id"
  end

  create_table "inventory_tallies", force: :cascade do |t|
    t.string "additional_location_info"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "inventory_type_id"
    t.bigint "storage_location_id"
    t.index ["inventory_type_id"], name: "index_inventory_tallies_on_inventory_type_id"
    t.index ["storage_location_id"], name: "index_inventory_tallies_on_storage_location_id"
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
    t.integer "location_type"
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

  create_table "message_logs", force: :cascade do |t|
    t.text "content"
    t.integer "delivery_type"
    t.string "delivery_status"
    t.integer "sent_to_id"
    t.integer "sent_by_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "messageable_type"
    t.bigint "messageable_id"
    t.string "subject_line"
    t.string "message_channel"
    t.string "message_type"
    t.index ["messageable_type", "messageable_id"], name: "index_message_logs_on_messageable_type_and_messageable_id"
    t.index ["sent_by_id"], name: "index_message_logs_on_sent_by_id"
    t.index ["sent_to_id"], name: "index_message_logs_on_sent_to_id"
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

  create_table "user_permissions", force: :cascade do |t|
    t.bigint "user_id"
    t.string "permission"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_user_permissions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer "invitation_limit"
    t.string "invited_by_type"
    t.bigint "invited_by_id"
    t.integer "invitations_count", default: 0
    t.bigint "volunteer_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["invitation_token"], name: "index_users_on_invitation_token", unique: true
    t.index ["invitations_count"], name: "index_users_on_invitations_count"
    t.index ["invited_by_id"], name: "index_users_on_invited_by_id"
    t.index ["invited_by_type", "invited_by_id"], name: "index_users_on_invited_by_type_and_invited_by_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["volunteer_id"], name: "index_users_on_volunteer_id"
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
    t.index ["university_location_id"], name: "index_volunteers_on_university_location_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "attendances", "meetings"
  add_foreign_key "attendances", "users"
  add_foreign_key "box_items", "boxes"
  add_foreign_key "box_items", "inventory_types"
  add_foreign_key "box_items", "users", column: "created_by_id"
  add_foreign_key "box_items", "users", column: "researched_by_id"
  add_foreign_key "box_items", "users", column: "updated_by_id"
  add_foreign_key "box_request_abuse_types", "abuse_types"
  add_foreign_key "box_request_abuse_types", "box_requests"
  add_foreign_key "box_requests", "requesters"
  add_foreign_key "box_requests", "users", column: "reviewed_by_id"
  add_foreign_key "boxes", "box_requests"
  add_foreign_key "boxes", "purchases", column: "shipping_payment_id"
  add_foreign_key "boxes", "users", column: "assembled_by_id"
  add_foreign_key "boxes", "users", column: "design_reviewed_by_id"
  add_foreign_key "boxes", "users", column: "designed_by_id"
  add_foreign_key "boxes", "users", column: "shipped_by_id"
  add_foreign_key "core_box_items", "abuse_types"
  add_foreign_key "core_box_items", "inventory_types"
  add_foreign_key "inventory_adjustments", "box_items"
  add_foreign_key "inventory_adjustments", "inventory_tallies"
  add_foreign_key "inventory_adjustments", "purchases"
  add_foreign_key "inventory_tallies", "inventory_types"
  add_foreign_key "inventory_tallies", "locations", column: "storage_location_id"
  add_foreign_key "meetings", "locations"
  add_foreign_key "meetings", "meeting_types"
  add_foreign_key "message_logs", "users", column: "sent_by_id"
  add_foreign_key "message_logs", "users", column: "sent_to_id"
  add_foreign_key "purchases", "locations"
  add_foreign_key "purchases", "users", column: "purchased_by_id"
  add_foreign_key "purchases", "users", column: "reimbursed_by_id"
  add_foreign_key "taggings", "tags"
  add_foreign_key "user_permissions", "users"
  add_foreign_key "users", "volunteers"
  add_foreign_key "volunteers", "locations", column: "university_location_id"
end
