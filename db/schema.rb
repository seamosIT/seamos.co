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

ActiveRecord::Schema.define(version: 20160811205909) do

  create_table "departamentos", force: :cascade do |t|
    t.string   "nombre"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "globales", force: :cascade do |t|
    t.string   "codigo",     null: false
    t.string   "valor",      null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["codigo"], name: "index_globales_on_codigo"
  end

  create_table "municipios", force: :cascade do |t|
    t.string   "nombre"
    t.integer  "departamento_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["departamento_id"], name: "index_municipios_on_departamento_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string   "codigo",     null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tipo_de_documentos", force: :cascade do |t|
    t.string   "codigo",     null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "primer_apellido"
    t.string   "segundo_apellido"
    t.string   "nombres"
    t.integer  "tipo_de_documento_id"
    t.string   "numero_documento"
    t.string   "provider"
    t.string   "uid"
    t.date     "fecha_expedicion"
    t.integer  "rol_id"
    t.boolean  "valido",                 default: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["numero_documento"], name: "index_users_on_numero_documento"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["rol_id"], name: "index_users_on_rol_id"
    t.index ["tipo_de_documento_id"], name: "index_users_on_tipo_de_documento_id"
  end

end
