require 'zlib' 
require 'open-uri'

class PropertyUpdatesJob < ApplicationJob
  queue_as :default


  def perform(*args, origin_company, xml_url)
    @updated = 0
    @created = 0
    @imported_from = origin_company
    @uri = xml_url
    @saved_zip = "./lib/tasks/#{@imported_from}.xml.gz"
    @xml_file = "./lib/tasks/#{@imported_from}.xml"

    puts "Easy Broker property updates started..."

    download_and_unzip
    create_or_update
    print_results
  end

  def print_results
    puts '#' * 30
    puts "Updated:  #{@updated}"
    puts "Created:  #{@created}"
    puts '#' * 30
  end

  def download_and_unzip
    # Download the file
    download = open(@uri)
    IO.copy_stream(download, @saved_zip)

    # Unzip the file
    Zlib::GzipReader.open(@saved_zip) do | input_stream |
      File.open(@xml_file, "w") do |output_stream|
        IO.copy_stream(input_stream, output_stream)
      end
    end
  end

  def create_or_update
    ## Loop through the properties and create them or update them if they dont exist
    doc = File.open(@xml_file) { |f| Nokogiri::XML(f) }
    doc.css('ad').each do |node|
      children = node.children

      # Save the values in a hash for easy access
      properties = {
        title: children.css('title').inner_text,
        estate_id: children.css('id').inner_text,
        description: children.css('content').inner_text,
        origin_company: @imported_from,
        property_type: children.css('type').inner_text,
        url: children.css('url').inner_text,
        status: children.css('type').inner_text,
        agency: children.css('agency').inner_text,
        price: children.css('price').inner_text,
        currency: get_currency_value(children),
        floor_area: children.css('floor_area').inner_text,
        unit: get_unit_value(children),
        rooms: children.css('rooms').inner_text,
        bathrooms: children.css('bathrooms').inner_text,
        city: children.css('city').inner_text,
        city_area: children.css('city_area').inner_text,
        region: children.css('region').inner_text,
        longitude: children.css('longitude').inner_text,
        latitude: children.css('latitude').inner_text,
        date: children.css('date').inner_text,
        time: children.css('time').inner_text,
        published: true
      }

      # Try to get the property from the database
      estate = Estate.where(estate_id: properties[:estate_id]).first

      if estate.nil?  # If not found create record
        create_estate(properties, children.css('picture'))
      else          # Else update record
        update_estate(estate, properties, children.css('picture'))
      end
    end

    # Now check for the deleted properties and unpublish them
    imported_ids = doc.css('id')
    check_unpublished(imported_ids)
  end


  def create_estate(properties, pictures)
    estate = Estate.create(properties)
    
    # Create pictures
    pictures.each do |picture|
      picture = Picture.create(estate: estate, url: picture.css('picture_url').inner_text)
      #estate.pictures << picture
    end
    @created += 1
  end


  def update_estate(estate, properties, pictures)
    estate.update(properties)

    # Remove old pictures
    estate.pictures.destroy_all

    # Create pictures
    pictures.each do |picture|
      picture = Picture.create(estate: estate, url: picture.css('picture_url').inner_text)
      #estate.pictures << picture
    end
    @updated += 1
  end


  def get_unit_value(children)
    # Check for nil value in floor_area node
    unit = ""
    unless children.css('floor_area').first.nil?
      unit = children.css('floor_area').first.attributes['unit'].value.to_s
    end
    return unit
  end


  def get_currency_value(children)
    # Check for nil value in price node
    currency = 0
    unless children.css('price').first.nil?
      currency = children.css('price').first.attributes['currency'].value.to_f
    end
    return currency
  end


  def check_unpublished(imported_ids)
    estates = Estate.published.by_company(@imported_from)

    found = false
    estates.each do |published_estate|
      # Search for the record and break if found
      imported_ids.each do |imported_id|
        if published_estate.estate_id == imported_id.inner_text
          found = true
          break
        end
      end

      # If record was not found then unpublish it
      if !found
        published_estate.updated(published: false)
      end
    end
  end

end
