class AddDescriptionToEstates < ActiveRecord::Migration[5.0]
  def change
  	add_column :estates, :description, :string
  end
end
