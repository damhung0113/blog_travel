class CreatePlaces < ActiveRecord::Migration[5.2]
  def change
    create_table :places do |t|
      t.string :name
      t.text :description
      t.string :address
      t.integer :vote
      t.string :cost
      t.integer :district_id
      t.string :photo
      t.integer :status
      t.references :district, foreign_key: true
      t.timestamps
    end
  end
end
