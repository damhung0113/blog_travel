class CreateParagraphs < ActiveRecord::Migration[5.2]
  def change
    create_table :paragraphs do |t|
      t.integer :blog_id
      t.string :title
      t.string :picture
      t.text :content
      t.references :blog, foreign_key: true
      t.timestamps
    end
  end
end
