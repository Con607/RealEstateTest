json.extract! estate, :id, :estate_id, :origin_company, :title, :property_type, :agency, :price, :currency, :unit, :floor_area, :rooms, :bathrooms, :city, :city_area, :region, :longitude, :latitude, :picture_ids, :date, :time, :published, :created_at, :updated_at
json.url estate_url(estate, format: :json)
