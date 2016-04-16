class CreateMatches < ActiveRecord::Migration[5.0]
  def change
    create_table :matches do |t|
      t.belongs_to :liker, null: false
      t.belongs_to :tinder_user, null: false
      t.timestamps
    end
  end
end
