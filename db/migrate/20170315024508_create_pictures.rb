class CreatePictures < ActiveRecord::Migration[5.0]
  def change
    create_table :pictures do |t|
      t.integer :estate_id
      t.string :url

      t.timestamps
    end
  end
end
