
require "test_helper"

class DonutsControllerTest < ActionDispatch::IntegrationTest
  test "gacha returns the requested number of donuts with details" do
    donuts = [
      Donut.create!(name: "ポン・デ・リング", group_name: "pon-de", price: 172),
      Donut.create!(name: "オールドファッション", group_name: "old-fashion", price: 172),
      Donut.create!(name: "フレンチクルーラー", group_name: "french", price: 172)
    ]

    post gacha_donuts_path, params: { quantity: 3 }

    assert_response :success

    results = JSON.parse(response.body)

    assert_equal 3, results.length

    results.each do |result|
      assert_equal %w[group_name name price], result.keys.sort

      donut = donuts.find { |item| item.name == result["name"] }

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

  test "gacha returns an error when no donuts exist" do
    Donut.delete_all

    post gacha_donuts_path, params: { quantity: 1 }

    assert_response :unprocessable_entity
    assert JSON.parse(response.body).key?("error")
  end

  test "gacha accepts the minimum and maximum quantities" do
    Donut.create!(name: "ポン・デ・リング", group_name: "pon-de", price: 172)

    [ 1, 10 ].each do |quantity|
      post gacha_donuts_path, params: { quantity: quantity }

      assert_response :success
      assert_equal quantity, JSON.parse(response.body).length
    end
  end
end
