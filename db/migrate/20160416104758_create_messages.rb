class CreateMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :messages do |t|
      t.belongs_to :tinder_user, null: false
      t.belongs_to :liker, null: false
      t.text :message
      t.timestamps
    end
  end
end
