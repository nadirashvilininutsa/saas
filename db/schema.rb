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

ActiveRecord::Schema[7.2].define(version: 2024_08_04_204050) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "artifacts", force: :cascade do |t|
    t.string "name", null: false
    t.string "file", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "artifactable_type", null: false
    t.bigint "artifactable_id", null: false
    t.bigint "organization_id", null: false
    t.bigint "user_id", null: false
    t.index ["artifactable_type", "artifactable_id"], name: "index_artifacts_on_artifactable"
    t.index ["organization_id"], name: "index_artifacts_on_organization_id"
    t.index ["user_id"], name: "index_artifacts_on_user_id"
  end

  create_table "comments", force: :cascade do |t|
    t.bigint "organization_id", null: false
    t.bigint "project_id", null: false
    t.bigint "task_id", null: false
    t.bigint "user_id", null: false
    t.text "content", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["organization_id"], name: "index_comments_on_organization_id"
    t.index ["project_id"], name: "index_comments_on_project_id"
    t.index ["task_id"], name: "index_comments_on_task_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "organizations", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "plan_id", null: false
    t.index ["name"], name: "index_organizations_on_name", unique: true
    t.index ["plan_id"], name: "index_organizations_on_plan_id"
  end

  create_table "permissions", force: :cascade do |t|
    t.string "name", null: false
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_permissions_on_name", unique: true
  end

  create_table "plan_description_plans", force: :cascade do |t|
    t.integer "plan_id", null: false
    t.integer "plan_description_id", null: false
    t.index ["plan_description_id"], name: "index_plan_description_plans_on_plan_description_id"
    t.index ["plan_id"], name: "index_plan_description_plans_on_plan_id"
  end

  create_table "plan_descriptions", force: :cascade do |t|
    t.text "content", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["content"], name: "index_plan_descriptions_on_content", unique: true
  end

  create_table "plans", force: :cascade do |t|
    t.string "name", null: false
    t.decimal "price", precision: 10, scale: 2, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_plans_on_name", unique: true
  end

  create_table "projects", force: :cascade do |t|
    t.string "title", null: false
    t.text "description", null: false
    t.date "completion_date", null: false
    t.boolean "completed", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "organization_id", null: false
    t.index ["completed"], name: "index_projects_on_completed"
    t.index ["organization_id"], name: "index_projects_on_organization_id"
    t.index ["title"], name: "index_projects_on_title", unique: true
  end

  create_table "projects_users", id: false, force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "project_id", null: false
    t.bigint "organization_id", null: false
    t.index ["organization_id"], name: "index_projects_users_on_organization_id"
    t.index ["project_id"], name: "index_projects_users_on_project_id"
    t.index ["user_id"], name: "index_projects_users_on_user_id"
  end

  create_table "role_permissions", force: :cascade do |t|
    t.integer "role_id", null: false
    t.integer "permission_id", null: false
    t.index ["permission_id"], name: "index_role_permissions_on_permission_id"
    t.index ["role_id"], name: "index_role_permissions_on_role_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_roles_on_name", unique: true
  end

  create_table "tasks", force: :cascade do |t|
    t.bigint "project_id", null: false
    t.bigint "user_id", null: false
    t.bigint "organization_id", null: false
    t.string "title", null: false
    t.text "description", null: false
    t.boolean "completed", default: false, null: false
    t.date "completion_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["completed"], name: "index_tasks_on_completed"
    t.index ["organization_id"], name: "index_tasks_on_organization_id"
    t.index ["project_id"], name: "index_tasks_on_project_id"
    t.index ["user_id"], name: "index_tasks_on_user_id"
  end

  create_table "user_permissions", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "permission_id", null: false
    t.bigint "organization_id", null: false
    t.index ["organization_id"], name: "index_user_permissions_on_organization_id"
    t.index ["permission_id"], name: "index_user_permissions_on_permission_id"
    t.index ["user_id"], name: "index_user_permissions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "organization_id", null: false
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer "invitation_limit"
    t.string "invited_by_type"
    t.bigint "invited_by_id"
    t.integer "invitations_count", default: 0
    t.bigint "role_id", null: false
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_users_on_deleted_at"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["invitation_token"], name: "index_users_on_invitation_token", unique: true
    t.index ["invited_by_id"], name: "index_users_on_invited_by_id"
    t.index ["invited_by_type", "invited_by_id"], name: "index_users_on_invited_by"
    t.index ["organization_id"], name: "index_users_on_organization_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["role_id"], name: "index_users_on_role_id"
  end

  add_foreign_key "artifacts", "organizations"
  add_foreign_key "artifacts", "users"
  add_foreign_key "comments", "organizations"
  add_foreign_key "comments", "projects"
  add_foreign_key "comments", "tasks"
  add_foreign_key "comments", "users"
  add_foreign_key "organizations", "plans"
  add_foreign_key "plan_description_plans", "plan_descriptions"
  add_foreign_key "plan_description_plans", "plans"
  add_foreign_key "projects", "organizations"
  add_foreign_key "projects_users", "organizations"
  add_foreign_key "projects_users", "projects"
  add_foreign_key "projects_users", "users"
  add_foreign_key "role_permissions", "permissions"
  add_foreign_key "role_permissions", "roles"
  add_foreign_key "tasks", "organizations"
  add_foreign_key "tasks", "projects"
  add_foreign_key "tasks", "users"
  add_foreign_key "user_permissions", "organizations"
  add_foreign_key "user_permissions", "permissions"
  add_foreign_key "user_permissions", "users"
  add_foreign_key "users", "organizations"
  add_foreign_key "users", "roles"
end
