class AddUrlToEstates < ActiveRecord::Migration[5.0]
  def change
  	add_column :estates, :url, :string
  end
end
