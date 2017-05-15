class CreateVacancies < ActiveRecord::Migration[5.0]
  def change
    create_table :vacancies do |t|
      t.string  :name
      t.date    :expires_at
      t.integer :salary
      t.string  :contact_info
      t.integer :skills, array: true, default: []

      t.timestamps
    end
  end
end
