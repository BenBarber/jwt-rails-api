class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.string :auth_token
      t.string :reset_token
      t.datetime :reset_token_expires

      t.timestamps null: false

      t.index :email
    end
  end
end
