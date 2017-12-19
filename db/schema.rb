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

ActiveRecord::Schema.define(version: 20171218155753) do

  create_table "doctors", force: :cascade do |t|
    t.string "name"
  end

  create_table "night_schedules", force: :cascade do |t|
    t.date "date"
    t.integer "nurse1_id"
    t.integer "nurse2_id"
    t.integer "nurse3_id"
    t.integer "nurse4_id"
    t.integer "nurse5_id"
    t.integer "nurse6_id"
    t.integer "nurse7_id"
    t.integer "nurse8_id"
    t.integer "nurse9_id"
  end

  create_table "nurses", force: :cascade do |t|
    t.string "name"
    t.string "gender"
    t.date "birthday"
    t.string "id_card_num"
    t.string "phone_number"
    t.float "salary"
    t.date "inaugural_date"
    t.boolean "is_lactation"
    t.boolean "is_pregnant"
    t.string "department"
    t.string "qualification"
    t.string "is_experienced"
    t.string "has_coach_qualification"
  end

  create_table "patients", force: :cascade do |t|
    t.string "name"
    t.string "gender"
    t.integer "age"
    t.string "bed"
    t.string "diagnosis"
  end

  create_table "surgeries", force: :cascade do |t|
    t.date "date"
    t.string "time"
    t.integer "room"
    t.integer "table"
    t.integer "patient_id"
    t.string "department"
    t.string "ward"
    t.string "surgery_name"
    t.string "anesthesia_method"
    t.integer "doctor_id"
    t.string "assistant"
    t.string "instrument_nurse_id"
    t.string "roving_nurse_id"
    t.string "remark"
  end

end
