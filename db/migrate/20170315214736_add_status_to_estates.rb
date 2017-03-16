class AddStatusToEstates < ActiveRecord::Migration[5.0]
  def change
  	add_column :estates, :status, :string
  end
end
