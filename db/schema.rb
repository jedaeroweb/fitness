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

ActiveRecord::Schema[7.1].define(version: 2023_12_30_084307) do
  create_table "account_categories", force: :cascade do |t|
    t.string "title", null: false
    t.integer "accounts_count", default: 0, null: false
    t.boolean "enable", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "account_orders", force: :cascade do |t|
    t.integer "account_id", null: false
    t.integer "order_id"
    t.boolean "enable", default: true, null: false
    t.index ["account_id"], name: "index_account_orders_on_account_id"
    t.index ["order_id"], name: "index_account_orders_on_order_id"
  end

  create_table "account_payments", force: :cascade do |t|
    t.integer "account_id", null: false
    t.integer "payment_id", null: false
    t.boolean "enable", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_account_payments_on_account_id"
    t.index ["payment_id"], name: "index_account_payments_on_payment_id"
  end

  create_table "account_products", force: :cascade do |t|
    t.integer "account_id", null: false
    t.integer "product_id"
    t.boolean "enable", default: true, null: false
    t.index ["account_id"], name: "index_account_products_on_account_id"
    t.index ["product_id"], name: "index_account_products_on_product_id"
  end

  create_table "accounts", force: :cascade do |t|
    t.integer "branch_id", null: false
    t.integer "account_category_id", null: false
    t.integer "user_id"
    t.date "transaction_date", null: false
    t.integer "income", default: 1, null: false
    t.integer "account", default: 0, null: false
    t.boolean "enable", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_category_id"], name: "index_accounts_on_account_category_id"
    t.index ["branch_id"], name: "index_accounts_on_branch_id"
    t.index ["user_id"], name: "index_accounts_on_user_id"
  end

  create_table "admin_contents", force: :cascade do |t|
    t.integer "admin_id", null: false
    t.text "content", null: false
    t.boolean "enable", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["admin_id"], name: "index_admin_contents_on_admin_id"
  end

  create_table "admin_login_logs", force: :cascade do |t|
    t.integer "admin_id", null: false
    t.integer "client_ip", limit: 8, null: false
    t.boolean "enable", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["admin_id"], name: "index_admin_login_logs_on_admin_id"
  end

  create_table "admin_pictures", force: :cascade do |t|
    t.integer "admin_id", null: false
    t.string "picture", null: false
    t.boolean "enable", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["admin_id"], name: "index_admin_pictures_on_admin_id"
  end

  create_table "admins", force: :cascade do |t|
    t.integer "branch_id", null: false
    t.string "name", limit: 60, null: false
    t.date "birthday"
    t.string "phone"
    t.boolean "gender"
    t.boolean "is_fc", default: false, null: false
    t.boolean "is_trainer", default: false, null: false
    t.float "commission_rate", default: 0.0, null: false
    t.date "registration_date", null: false
    t.boolean "enable", default: true, null: false
    t.integer "sign_in_count", default: 0
    t.datetime "current_sign_in_at", precision: nil
    t.datetime "last_sign_in_at", precision: nil
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["branch_id"], name: "index_admins_on_branch_id"
  end

  create_table "authentication_providers", force: :cascade do |t|
    t.string "name", limit: 60, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_name_on_authentication_providers"
  end

  create_table "branch_pictures", force: :cascade do |t|
    t.integer "branch_id", null: false
    t.string "picture", null: false
    t.boolean "enable", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["branch_id"], name: "index_branch_pictures_on_branch_id"
  end

  create_table "branch_setting_payments", force: :cascade do |t|
    t.integer "branch_setting_id", null: false
    t.integer "payment_id", null: false
    t.boolean "enable", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["branch_setting_id"], name: "index_branch_setting_payments_on_branch_setting_id"
    t.index ["payment_id"], name: "index_branch_setting_payments_on_payment_id"
  end

  create_table "branch_settings", force: :cascade do |t|
    t.integer "branch_id", null: false
    t.boolean "use_group", default: true, null: false
    t.boolean "use_unique_number", default: true, null: false
    t.boolean "use_product_category", default: true, null: false
    t.boolean "enable", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["branch_id"], name: "index_branch_settings_on_branch_id"
  end

  create_table "branches", force: :cascade do |t|
    t.integer "company_id", null: false
    t.string "title", limit: 60, null: false
    t.integer "sample", default: 0, null: false
    t.integer "admins_count", default: 0, null: false
    t.integer "users_count", default: 0, null: false
    t.integer "product_categories_count", default: 0, null: false
    t.integer "products_count", default: 0, null: false
    t.integer "orders_count", default: 0, null: false
    t.integer "accounts_count", default: 0, null: false
    t.string "locale", limit: 10, default: "ko", null: false
    t.boolean "enable", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_branches_on_company_id"
  end

  create_table "check_ins", force: :cascade do |t|
    t.integer "branch_id", null: false
    t.integer "user_id", null: false
    t.datetime "in_time", precision: nil, null: false
    t.boolean "enable", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["branch_id"], name: "index_check_ins_on_branch_id"
    t.index ["user_id"], name: "index_check_ins_on_user_id"
  end

  create_table "companies", force: :cascade do |t|
    t.string "title", limit: 60, null: false
    t.integer "branches_count", default: 0, null: false
    t.boolean "premium", default: false, null: false
    t.boolean "enable", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "counsel_contents", force: :cascade do |t|
    t.text "content", null: false
  end

  create_table "counsels", force: :cascade do |t|
    t.integer "branch_id", null: false
    t.integer "admin_id"
    t.string "title", limit: 60, null: false
    t.date "registered_date", null: false
    t.boolean "complete", default: false, null: false
    t.boolean "enable", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["admin_id"], name: "index_counsels_on_admin_id"
    t.index ["branch_id"], name: "index_counsels_on_branch_id"
  end

  create_table "course_period_types", force: :cascade do |t|
    t.integer "course_id", null: false
    t.integer "period_type_id", null: false
    t.boolean "enable", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_course_period_types_on_course_id"
    t.index ["period_type_id"], name: "index_course_period_types_on_period_type_id"
  end

  create_table "courses", force: :cascade do |t|
    t.integer "product_id", null: false
    t.integer "order_no", default: 1, null: false
    t.integer "default_quantity", default: 1, null: false
    t.boolean "enable", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_courses_on_product_id"
  end

  create_table "enroll_trainers", force: :cascade do |t|
    t.integer "enroll_id", null: false
    t.integer "admin_id", null: false
    t.index ["admin_id"], name: "index_enroll_trainers_on_admin_id"
    t.index ["enroll_id"], name: "index_enroll_trainers_on_enroll_id"
  end

  create_table "enrolls", force: :cascade do |t|
    t.integer "order_id", null: false
    t.integer "period_type_id", default: 1, null: false
    t.integer "quantity", default: 1, null: false
    t.date "start_date", null: false
    t.date "end_date", null: false
    t.boolean "enable", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_enrolls_on_order_id"
    t.index ["period_type_id"], name: "index_enrolls_on_period_type_id"
  end

  create_table "exercise_categories", force: :cascade do |t|
    t.integer "branch_id"
    t.string "title", null: false
    t.integer "order_no", default: 0, null: false
    t.integer "exercises_count", default: 0, null: false
    t.boolean "enable", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["branch_id"], name: "index_exercise_categories_on_branch_id"
  end

  create_table "exercise_contents", force: :cascade do |t|
    t.text "content", null: false
  end

  create_table "exercise_pictures", force: :cascade do |t|
    t.integer "exercise_id", null: false
    t.string "picture", null: false
    t.boolean "enable", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["exercise_id"], name: "index_exercise_pictures_on_exercise_id"
  end

  create_table "exercises", force: :cascade do |t|
    t.integer "branch_id"
    t.integer "admin_id"
    t.integer "exercise_category_id", null: false
    t.string "title", limit: 60, null: false
    t.boolean "enable", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["admin_id"], name: "index_exercises_on_admin_id"
    t.index ["branch_id"], name: "index_exercises_on_branch_id"
    t.index ["exercise_category_id"], name: "index_exercises_on_exercise_category_id"
  end

  create_table "groups", force: :cascade do |t|
    t.integer "branch_id", null: false
    t.string "title", limit: 60, null: false
    t.string "description", limit: 250
    t.integer "users_count", default: 0, null: false
    t.boolean "enable", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["branch_id", "title"], name: "index_groups_on_branch_id_and_title", unique: true
    t.index ["branch_id"], name: "index_groups_on_branch_id"
  end

  create_table "impressions", force: :cascade do |t|
    t.string "impressionable_type"
    t.integer "impressionable_id"
    t.integer "user_id"
    t.string "controller_name"
    t.string "action_name"
    t.string "view_name"
    t.string "request_hash"
    t.string "ip_address"
    t.string "session_hash"
    t.text "message"
    t.text "referrer"
    t.text "params"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["controller_name", "action_name", "ip_address"], name: "controlleraction_ip_index"
    t.index ["controller_name", "action_name", "request_hash"], name: "controlleraction_request_index"
    t.index ["controller_name", "action_name", "session_hash"], name: "controlleraction_session_index"
    t.index ["impressionable_type", "impressionable_id", "ip_address"], name: "poly_ip_index"
    t.index ["impressionable_type", "impressionable_id", "params"], name: "poly_params_request_index"
    t.index ["impressionable_type", "impressionable_id", "request_hash"], name: "poly_request_index"
    t.index ["impressionable_type", "impressionable_id", "session_hash"], name: "poly_session_index"
    t.index ["impressionable_type", "message", "impressionable_id"], name: "impressionable_type_message_index"
    t.index ["user_id"], name: "index_impressions_on_user_id"
  end

  create_table "jobs", force: :cascade do |t|
    t.string "title", limit: 60, null: false
    t.string "description", limit: 200
    t.integer "user_additionals_count", default: 0, null: false
    t.boolean "enable", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "locker_period_types", force: :cascade do |t|
    t.integer "locker_id", null: false
    t.integer "period_type_id", null: false
    t.boolean "enable", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["locker_id"], name: "index_locker_period_types_on_locker_id"
    t.index ["period_type_id"], name: "index_locker_period_types_on_period_type_id"
  end

  create_table "locker_rentals", force: :cascade do |t|
    t.integer "order_id", null: false
    t.integer "period_type_id", default: 1, null: false
    t.integer "no"
    t.integer "quantity", default: 1, null: false
    t.date "start_date", null: false
    t.date "end_date", null: false
    t.boolean "enable", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_locker_rentals_on_order_id"
    t.index ["period_type_id"], name: "index_locker_rentals_on_period_type_id"
  end

  create_table "lockers", force: :cascade do |t|
    t.integer "product_id", null: false
    t.integer "order_no", default: 1, null: false
    t.integer "quantity", default: 1, null: false
    t.integer "start_no", default: 1, null: false
    t.boolean "gender", default: true, null: false
    t.boolean "use_not_set", default: false, null: false
    t.boolean "enable", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_lockers_on_product_id"
  end

  create_table "message_contents", force: :cascade do |t|
    t.text "content", null: false
  end

  create_table "message_receivers", force: :cascade do |t|
    t.integer "message_id", null: false
    t.integer "user_id", null: false
    t.boolean "enable", default: true, null: false
    t.index ["message_id"], name: "index_message_receivers_on_message_id"
    t.index ["user_id"], name: "index_message_receivers_on_user_id"
  end

  create_table "message_results", force: :cascade do |t|
    t.integer "message_id", null: false
    t.integer "result_code", null: false
    t.string "result_message", null: false
    t.integer "msg_id", null: false
    t.string "msg_type", null: false
    t.integer "success_cnt", default: 0, null: false
    t.integer "error_cnt", default: 0, null: false
    t.boolean "enable", default: true, null: false
    t.index ["message_id"], name: "index_message_results_on_message_id"
  end

  create_table "message_send_types", force: :cascade do |t|
    t.string "title", limit: 60, null: false
    t.boolean "enable", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "message_senders", force: :cascade do |t|
    t.integer "message_id", null: false
    t.integer "admin_id", null: false
    t.boolean "enable", default: true, null: false
    t.index ["admin_id"], name: "index_message_senders_on_admin_id"
    t.index ["message_id"], name: "index_message_senders_on_message_id"
  end

  create_table "messages", force: :cascade do |t|
    t.integer "branch_id", null: false
    t.integer "message_send_type_id", default: 1, null: false
    t.string "title", limit: 60, null: false
    t.integer "send_all", default: 0, null: false
    t.boolean "enable", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["branch_id"], name: "index_messages_on_branch_id"
    t.index ["message_send_type_id"], name: "index_messages_on_message_send_type_id"
  end

  create_table "notice_contents", force: :cascade do |t|
    t.text "content", null: false
  end

  create_table "notices", force: :cascade do |t|
    t.integer "branch_id", null: false
    t.integer "admin_id"
    t.string "title", limit: 60, null: false
    t.integer "default_view_count", default: 0, null: false
    t.boolean "enable", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["admin_id"], name: "index_notices_on_admin_id"
    t.index ["branch_id"], name: "index_notices_on_branch_id"
  end

  create_table "order_admins", force: :cascade do |t|
    t.integer "order_id", null: false
    t.integer "admin_id", null: false
    t.boolean "enable", default: true, null: false
    t.index ["admin_id"], name: "index_order_admins_on_admin_id"
    t.index ["order_id"], name: "index_order_admins_on_order_id"
  end

  create_table "order_contents", force: :cascade do |t|
    t.integer "order_id", null: false
    t.text "content", null: false
    t.boolean "enable", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_order_contents_on_order_id"
  end

  create_table "order_products", force: :cascade do |t|
    t.integer "order_id", null: false
    t.integer "product_id", null: false
    t.integer "price", default: 0, null: false
    t.integer "quantity", default: 0, null: false
    t.boolean "enable", default: true, null: false
    t.index ["order_id"], name: "index_order_products_on_order_id"
    t.index ["product_id"], name: "index_order_products_on_product_id"
  end

  create_table "orders", force: :cascade do |t|
    t.integer "branch_id", null: false
    t.integer "user_id"
    t.date "last_transaction_date", null: false
    t.integer "total_price", default: 0, null: false
    t.integer "total_discount", default: 0, null: false
    t.integer "total_payment", default: 0, null: false
    t.boolean "enable", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["branch_id"], name: "index_orders_on_branch_id"
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "payments", force: :cascade do |t|
    t.string "title", limit: 60, null: false
    t.boolean "enable", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "period_types", force: :cascade do |t|
    t.string "title", limit: 60, null: false
    t.boolean "enable", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "point_logs", force: :cascade do |t|
    t.integer "point_id", null: false
    t.integer "charge", default: 0, null: false
    t.string "refund", default: "0", null: false
    t.boolean "enable", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["point_id"], name: "index_point_logs_on_point_id"
  end

  create_table "points", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "point", default: 0, null: false
    t.integer "point_logs_count", default: 0, null: false
    t.boolean "enable", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_points_on_user_id"
  end

  create_table "prepared_message_contents", force: :cascade do |t|
    t.text "content", null: false
  end

  create_table "prepared_messages", force: :cascade do |t|
    t.integer "branch_id", null: false
    t.string "title", limit: 60, null: false
    t.integer "messages_count", default: 0, null: false
    t.boolean "enable", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["branch_id"], name: "index_prepared_messages_on_branch_id"
  end

  create_table "product_categories", force: :cascade do |t|
    t.integer "branch_id", null: false
    t.string "title", null: false
    t.integer "order_no", default: 0, null: false
    t.integer "products_count", default: 0, null: false
    t.boolean "enable", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["branch_id"], name: "index_product_categories_on_branch_id"
  end

  create_table "product_contents", force: :cascade do |t|
    t.integer "product_id", null: false
    t.text "content", null: false
    t.boolean "enable", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_product_contents_on_product_id"
  end

  create_table "product_pictures", force: :cascade do |t|
    t.integer "product_id", null: false
    t.string "picture", null: false
    t.boolean "enable", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_product_pictures_on_product_id"
  end

  create_table "products", force: :cascade do |t|
    t.integer "branch_id", null: false
    t.integer "product_category_id"
    t.string "title", limit: 60, null: false
    t.string "description", limit: 200
    t.integer "order_no", default: 0, null: false
    t.integer "price", default: 0, null: false
    t.integer "product_pictures_count", default: 0, null: false
    t.boolean "enable", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["branch_id"], name: "index_products_on_branch_id"
    t.index ["product_category_id"], name: "index_products_on_product_category_id"
  end

  create_table "role_admins", force: :cascade do |t|
    t.integer "role_id", null: false
    t.integer "admin_id", null: false
    t.index ["admin_id"], name: "index_role_admins_on_admin_id"
    t.index ["role_id"], name: "index_role_admins_on_role_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "title", limit: 60, null: false
    t.string "role", limit: 60, null: false
    t.boolean "enable", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sports_wear_rentals", force: :cascade do |t|
    t.integer "order_id", null: false
    t.integer "period_type_id", default: 1, null: false
    t.integer "quantity", default: 1, null: false
    t.date "start_date", null: false
    t.date "end_date", null: false
    t.boolean "enable", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_sports_wear_rentals_on_order_id"
    t.index ["period_type_id"], name: "index_sports_wear_rentals_on_period_type_id"
  end

  create_table "sports_wears", force: :cascade do |t|
    t.integer "product_id", null: false
    t.boolean "gender", default: true, null: false
    t.boolean "enable", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_sports_wears_on_product_id"
  end

  create_table "user_additionals", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "job_id"
    t.integer "visit_route_id"
    t.string "company", limit: 60
    t.boolean "enable", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["job_id"], name: "index_user_additionals_on_job_id"
    t.index ["user_id"], name: "index_user_additionals_on_user_id"
    t.index ["visit_route_id"], name: "index_user_additionals_on_visit_route_id"
  end

  create_table "user_admins", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "admin_id", null: false
    t.index ["admin_id"], name: "index_user_admins_on_admin_id"
    t.index ["user_id"], name: "index_user_admins_on_user_id"
  end

  create_table "user_authentications", force: :cascade do |t|
    t.integer "user_id"
    t.integer "authentication_provider_id"
    t.string "uid"
    t.string "token"
    t.datetime "token_expires_at", precision: nil
    t.text "params"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["authentication_provider_id"], name: "index_user_authentications_on_authentication_provider_id"
    t.index ["user_id"], name: "index_user_authentications_on_user_id"
  end

  create_table "user_contents", force: :cascade do |t|
    t.integer "user_id", null: false
    t.text "content", null: false
    t.boolean "enable", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_user_contents_on_user_id"
  end

  create_table "user_devices", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "os", default: "android", null: false
    t.string "token", limit: 150, null: false
    t.boolean "enable", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_user_devices_on_user_id"
  end

  create_table "user_fcs", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "admin_id", null: false
    t.index ["admin_id"], name: "index_user_fcs_on_admin_id"
    t.index ["user_id"], name: "index_user_fcs_on_user_id"
  end

  create_table "user_groups", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "group_id", null: false
    t.index ["group_id"], name: "index_user_groups_on_group_id"
    t.index ["user_id"], name: "index_user_groups_on_user_id"
  end

  create_table "user_pictures", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "picture", null: false
    t.boolean "enable", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_user_pictures_on_user_id"
  end

  create_table "user_trainers", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "admin_id", null: false
    t.index ["admin_id"], name: "index_user_trainers_on_admin_id"
    t.index ["user_id"], name: "index_user_trainers_on_user_id"
  end

  create_table "user_unique_numbers", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "unique_number", limit: 60, null: false
    t.index ["user_id"], name: "index_user_unique_numbers_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.integer "branch_id", null: false
    t.string "name", limit: 60, null: false
    t.string "encrypted_password", limit: 60, null: false
    t.string "email", limit: 60
    t.string "phone", limit: 20
    t.date "birthday"
    t.boolean "gender"
    t.datetime "remember_created_at", precision: nil
    t.integer "sign_in_count", default: 0
    t.datetime "current_sign_in_at", precision: nil
    t.datetime "last_sign_in_at", precision: nil
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.date "registration_date", null: false
    t.integer "orders_count", default: 0, null: false
    t.integer "accounts_count", default: 0, null: false
    t.integer "user_admins_count", default: 0, null: false
    t.boolean "enable", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["branch_id"], name: "index_users_on_branch_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["phone"], name: "index_users_on_phone", unique: true
  end

  create_table "visit_routes", force: :cascade do |t|
    t.string "title", limit: 60, null: false
    t.string "description", limit: 200
    t.integer "user_additionals_count", default: 0, null: false
    t.boolean "enable", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
