require "test_helper"

class DonutsControllerTest < ActionDispatch::IntegrationTest
  test "donut catalog contains 31 items" do
    assert_equal 31, Donut.all.length
  end

  test "gacha returns the requested number of donuts with details" do
    post gacha_donuts_path, params: { quantity: 3 }

    assert_response :success

    results = JSON.parse(response.body)

    assert_equal 3, results.length

    results.each do |result|
      assert_equal %w[group_name name price], result.keys.sort

      donut = Donut.all.find { |item| item.name == result["name"] }

      assert_not_nil donut
      assert_equal donut.group_name, result["group_name"]
      assert_equal donut.price, result["price"]
    end
  end

  test "gacha rejects invalid quantities" do
    [ 0, 11, -1, "abc", "" ].each do |quantity|
      post gacha_donuts_path, params: { quantity: quantity }

      assert_response :bad_request
      assert JSON.parse(response.body).key?("error")
    end
  end

  test "gacha accepts the minimum and maximum quantities" do
    [ 1, 10 ].each do |quantity|
      post gacha_donuts_path, params: { quantity: quantity }

      assert_response :success
      assert_equal quantity, JSON.parse(response.body).length
    end
  end
end
