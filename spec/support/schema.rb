ActiveRecord::Schema.define(version: 1) do
  create_table "ponies", force: true do |t|
    t.string  "identifier"
  end
  create_table "dogs", force: true do |t|
    t.string "mad_id"
  end
end
