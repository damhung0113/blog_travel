class CreateBookmarks < ActiveRecord::Migration[5.2]
  def change
    create_table :bookmarks do |t|
      t.integer :bookmarkable_id
      t.string :bookmarkable_type
      t.belongs_to :user
      t.timestamps
    end
  end
end
