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

ActiveRecord::Schema[8.0].define(version: 2025_06_13_134924) do
  create_table "forum_categories", force: :cascade do |t|
    t.string "name", null: false
    t.string "slug", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "bg_color", null: false
    t.integer "topics_count", default: 0
    t.index ["slug"], name: "index_forum_categories_on_slug", unique: true
  end

  create_table "forum_posts", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "topic_id", null: false
    t.text "content", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["topic_id"], name: "index_forum_posts_on_topic_id"
    t.index ["user_id"], name: "index_forum_posts_on_user_id"
  end

  create_table "forum_taggables", force: :cascade do |t|
    t.bigint "topic_id", null: false
    t.bigint "tag_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tag_id"], name: "index_forum_taggables_on_tag_id"
    t.index ["topic_id"], name: "index_forum_taggables_on_topic_id"
  end

  create_table "forum_tags", force: :cascade do |t|
    t.string "name", null: false
    t.string "slug", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "topics_count", default: 0, null: false
    t.index ["slug"], name: "index_forum_tags_on_slug", unique: true
    t.index ["topics_count"], name: "index_forum_tags_on_topics_count"
  end

  create_table "forum_topics", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "category_id", null: false
    t.string "title", limit: 255, null: false
    t.string "slug", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "content", null: false
    t.integer "num_views", default: 0
    t.integer "posts_count", default: 0, null: false
    t.datetime "active_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.datetime "pinned_at"
    t.integer "tags_count", default: 0, null: false
    t.index ["active_at"], name: "index_forum_topics_on_active_at"
    t.index ["category_id"], name: "index_forum_topics_on_category_id"
    t.index ["posts_count"], name: "index_forum_topics_on_posts_count"
    t.index ["slug"], name: "index_forum_topics_on_slug", unique: true
    t.index ["tags_count"], name: "index_forum_topics_on_tags_count"
    t.index ["user_id"], name: "index_forum_topics_on_user_id"
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string "slug", null: false
    t.integer "sluggable_id", null: false
    t.string "sluggable_type", limit: 50
    t.string "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["sluggable_type", "sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_type_and_sluggable_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.string "resource_type"
    t.integer "resource_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id"
    t.index ["name"], name: "index_roles_on_name"
    t.index ["resource_type", "resource_id"], name: "index_roles_on_resource"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "username", null: false
    t.string "avatar_bg_color", null: false
    t.integer "posts_count", default: 0, null: false
    t.integer "topics_count", default: 0, null: false
    t.string "slug"
    t.string "provider"
    t.string "uid"
    t.integer "state", default: 0, null: false
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["slug"], name: "index_users_on_slug", unique: true
    t.index ["state"], name: "index_users_on_state"
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  create_table "users_roles", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "role_id"
    t.index ["role_id"], name: "index_users_roles_on_role_id"
    t.index ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id"
    t.index ["user_id"], name: "index_users_roles_on_user_id"
  end

  add_foreign_key "forum_posts", "forum_topics", column: "topic_id"
  add_foreign_key "forum_posts", "users"
  add_foreign_key "forum_taggables", "forum_tags", column: "tag_id"
  add_foreign_key "forum_taggables", "forum_topics", column: "topic_id"
  add_foreign_key "forum_topics", "forum_categories", column: "category_id"
  add_foreign_key "forum_topics", "users"
end
