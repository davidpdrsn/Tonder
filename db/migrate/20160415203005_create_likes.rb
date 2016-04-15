class CreateLikes < ActiveRecord::Migration[5.0]
  def change
    create_table :likes do |t|
      t.belongs_to :tinder_user
      t.belongs_to :liker
      t.timestamps
    end
  end
end
