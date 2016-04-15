class CreateImages < ActiveRecord::Migration[5.0]
  def change
    create_table :images do |t|
      t.text :url
      t.belongs_to :tinder_user
      t.timestamps
    end
  end
end
