class CreateProfiles < ActiveRecord::Migration[5.0]
  def change
    create_table :profiles do |t|
      t.integer  :user_id
      t.string   :address
      t.string   :phone, limit: 10
      t.integer  :salary, default: 0
      t.boolean  :act, default: true
      t.integer  :skills, array: true, default: []

      t.timestamps
    end
    add_index :profiles, :user_id, unique: true
  end
end
