class CreateSkills < ActiveRecord::Migration[5.0]
  def change
    create_table :skills do |t|
      t.string  :name, uniq: true
      t.boolean :accepted, default: false

      t.timestamps
    end
  end
end
