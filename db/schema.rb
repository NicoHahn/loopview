# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_12_08_155657) do

  create_table "concrete_issue_templates", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "issue_template_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "project_id"
    t.integer "external_id"
    t.index ["issue_template_id"], name: "index_concrete_issue_templates_on_issue_template_id"
    t.index ["project_id"], name: "index_concrete_issue_templates_on_project_id"
  end

  create_table "concrete_template_values", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "issue_template_attribute_id"
    t.string "extended_field_value"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "concrete_issue_template_id"
    t.text "dynamic_size_data"
    t.index ["concrete_issue_template_id"], name: "index_concrete_template_values_on_concrete_issue_template_id"
    t.index ["issue_template_attribute_id"], name: "index_concrete_template_values_on_issue_template_attribute_id"
  end

  create_table "issue_template_attributes", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "issue_template_id"
    t.integer "attribute_type"
    t.string "field_title"
    t.string "field_value"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "optional_size", default: 0
    t.string "optional_code_language"
    t.index ["issue_template_id"], name: "index_issue_template_attributes_on_issue_template_id"
  end

  create_table "issue_templates", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "title"
  end

  create_table "projects", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.integer "external_id"
    t.string "external_key"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "external_title"
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "firstname"
    t.string "lastname"
    t.string "email"
    t.string "api_key"
    t.string "password_digest"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "passwd_changed", default: false
  end

  add_foreign_key "concrete_issue_templates", "issue_templates"
  add_foreign_key "concrete_issue_templates", "projects"
  add_foreign_key "concrete_template_values", "concrete_issue_templates"
  add_foreign_key "concrete_template_values", "issue_template_attributes"
  add_foreign_key "issue_template_attributes", "issue_templates"
end
