class CreateBlogs < ActiveRecord::Migration[5.2]
  def change
    create_table :blogs do |t|
      t.integer :user_id
      t.integer :district_id
      t.string :cover_photo
      t.string :topic
      t.string :address
      t.string :content
      t.references :user, foreign_key: true
      t.references :district, foreign_key: true
      t.timestamps
    end
  end
end
