class CreateTinderUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :tinder_users do |t|
      t.string :tinder_id, null: false
      t.string :name, null: false
      t.text :bio, null: false
      t.integer :gender, null: false
      t.datetime :birth_date, null: false

      t.timestamps
    end

    add_index :tinder_users, :tinder_id, unique: true
  end
end
