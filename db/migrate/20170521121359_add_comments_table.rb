class AddCommentsTable < ActiveRecord::Migration[5.0]
  def change
    create_table :comments do |t|
      t.text       :body
      t.integer    :rank
      t.references :vacancy, index: true
      t.references :user,    index: true
      t.integer    :parent_id, default: 0

      t.timestamp
    end

    add_index :comments, :parent_id
  end
end
