require "test_helper"

class TestShopQueries < Minitest::Test
  def setup
    @endpoint = "https://api.spreadshop.com/v1/graphql"
    @get_shop_query = SpreadshopClient::Models::ShopQueries::GET_SHOP
  end

  def test_get_shop_query
    stub_request(:post, @endpoint)
      .with(
        body: {
          query: @get_shop_query,
          variables: {
            name: "test_shop",
            platform: "test_platform",
            locale: "en_US"
          }
        }.to_json,
        headers: {"Content-Type" => "application/json"}
      )
      .to_return(
        status: 200,
        body: {
          data: {
            shop: {
              id: "12345",
              name: "test_shop"
            }
          }
        }.to_json
      )

    response = SpreadshopClient::Shop.get_shop(name: "test_shop", platform: "test_platform", locale: "en_US")
    assert_instance_of SpreadshopClient::Models::ShopModel, response
    assert_equal "12345", response.id
    assert_equal "test_shop", response.name
  end
end
