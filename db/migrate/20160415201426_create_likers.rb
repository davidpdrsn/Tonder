class CreateLikers < ActiveRecord::Migration[5.0]
  def change
    create_table :likers do |t|
      t.text :facebook_id
      t.text :facebook_token
      t.timestamps
    end
  end
end
