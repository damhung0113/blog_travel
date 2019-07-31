class CreateGenerals < ActiveRecord::Migration[5.2]
  def change
    create_table :generals do |t|
      t.integer :user_id
      t.integer :blog_id
      t.integer :generalable_id
      t.string :generalable_type
      t.references :user, foreign_key: true
      t.references :blog, foreign_key: true
      t.timestamps
    end
  end
end
