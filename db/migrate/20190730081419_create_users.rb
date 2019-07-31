class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.string :remember_digest
      t.string :avatar
      t.boolean :is_admin
      t.string :uid
      t.string :provider
      t.timestamps
    end
    add_index :users, :email, unique: true
  end
end
