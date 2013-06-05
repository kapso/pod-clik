class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first_name, limit: 50, null: false
      t.string :last_name, limit: 50
      t.string :email, limit: 100
      t.boolean :emailable, null: false
      t.string :phone_country_code, limit: 10, null: false
      t.string :phone_number, limit: 20, null: false
      t.string :phone_verify_code, limit: 20, null: false
      t.boolean :phone_verified, null: false
      t.string :time_zone, limit: 250
      t.integer :state_enum, null: false
      t.references :school, null: false

      # Sorcery db auth
      t.string :crypted_password, default: nil
      t.string :salt,             default: nil

      t.timestamps null: false
    end

    add_index :users, :email, unique: true
    add_index :users, :phone_number, unique: true
    add_index :users, :school_id
  end
end
