class CreateEstates < ActiveRecord::Migration[5.0]
  def change
    create_table :estates do |t|
      t.string :estate_id
      t.string :origin_company
      t.string :title
      t.string :property_type
      t.string :agency
      t.float :price
      t.string :currency
      t.string :unit
      t.integer :floor_area
      t.integer :rooms
      t.integer :bathrooms
      t.string :city
      t.string :city_area
      t.string :region
      t.float :longitude
      t.float :latitude
      t.integer :picture_ids
      t.date :date
      t.time :time
      t.boolean :published

      t.timestamps
    end
    add_index :estates, :estate_id, :unique => true
  end
end
