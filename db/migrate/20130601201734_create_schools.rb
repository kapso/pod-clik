class CreateSchools < ActiveRecord::Migration
  def change
    create_table :schools do |t|
      t.string :name, limit: 100, null: false
      t.string :address, limit: 50, null: false
      t.string :city, limit: 50, null: false
      t.string :state, limit: 100, null: false
      t.string :zip, limit: 15, null: false
      t.column :coordinates, :point, null: false
      t.integer :type_enum, null: false
      t.integer :state_enum, null: false
      t.timestamps null: false
    end

    execute "CREATE INDEX index_schools_on_coordinates ON schools USING gist(coordinates);"
  end
end
