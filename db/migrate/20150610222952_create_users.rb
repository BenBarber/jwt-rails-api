class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.string :auth_signature
      t.datetime :auth_signature_created_at

      t.timestamps null: false

      t.index :email
    end
  end
end
