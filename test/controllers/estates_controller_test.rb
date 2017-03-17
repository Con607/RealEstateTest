require 'test_helper'

class EstatesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @estate = estates(:one)
  end

  test "should get index" do
    get estates_url
    assert_response :success
  end

  test "should get new" do
    get new_estate_url
    assert_response :success
  end

  test "should create estate" do
    assert_difference('Estate.count') do
      post estates_url, params: { estate: { agency: @estate.agency, bathrooms: @estate.bathrooms, city: @estate.city, city_area: @estate.city_area, currency: @estate.currency, date: @estate.date, property_id: @estate.property_id, floor_area: @estate.floor_area, latitude: @estate.latitude, longitude: @estate.longitude, origin_company: @estate.origin_company, picture_ids: @estate.picture_ids, price: @estate.price, property_type: @estate.property_type, published: @estate.published, region: @estate.region, rooms: @estate.rooms, time: @estate.time, title: @estate.title, unit: @estate.unit } }
    end

    assert_redirected_to estate_url(Estate.last)
  end

  test "should show estate" do
    get estate_url(@estate)
    assert_response :success
  end

  test "should get edit" do
    get edit_estate_url(@estate)
    assert_response :success
  end

  test "should update estate" do
    patch estate_url(@estate), params: { estate: { agency: @estate.agency, bathrooms: @estate.bathrooms, city: @estate.city, city_area: @estate.city_area, currency: @estate.currency, date: @estate.date, property_id: @estate.property_id, floor_area: @estate.floor_area, latitude: @estate.latitude, longitude: @estate.longitude, origin_company: @estate.origin_company, picture_ids: @estate.picture_ids, price: @estate.price, property_type: @estate.property_type, published: @estate.published, region: @estate.region, rooms: @estate.rooms, time: @estate.time, title: @estate.title, unit: @estate.unit } }
    assert_redirected_to estate_url(@estate)
  end

  test "should destroy estate" do
    assert_difference('Estate.count', -1) do
      delete estate_url(@estate)
    end

    assert_redirected_to estates_url
  end

  # IN prgoress
  #test "can publish a estate" do
  #  estate = estates(:one)
  #  assert_equal estate.published == true, estate.publish
  #end

end
