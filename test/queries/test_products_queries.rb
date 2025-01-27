require "test_helper"

class TestProductQueries < Minitest::Test
  def setup
    @endpoint = "https://api.spreadshop.com/v1/graphql"
    @get_products_query = SpreadshopClient::Queries::ProductsQueries::GET_PRODUCTS
  end

  def test_get_all_products
    stub_request(:post, @endpoint)
      .with(
        body: {
          query: @get_products_query,
          variables: {
            shopId: "12345",
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
            products: {
              items: [
                {
                  id: "product_1",
                  name: "Product One",
                  image: {
                    src: "image_url_1",
                    srcset: "image_srcset_1",
                    altText: "alt_text_1",
                    format: "PNG"
                  },
                  price: {
                    vatExcluded: nil,
                    vatIncluded: 10.99,
                    vatAmount: nil
                  }
                },
                {
                  id: "product_2",
                  name: "Product Two",
                  image: {
                    src: "image_url_2",
                    srcset: "image_srcset_2",
                    altText: "alt_text_2",
                    format: "JPG"
                  },
                  price: {
                    vatExcluded: nil,
                    vatIncluded: 20.99,
                    vatAmount: nil
                  }
                }
              ]
            }
          }
        }.to_json
      )

    products = SpreadshopClient::Product.get_all(shop_id: "12345", platform: "test_platform", locale: "en_US")
    assert_instance_of Array, products
    assert_equal 2, products.size

    first_product = products.first
    assert_instance_of SpreadshopClient::Product, first_product
    assert_equal "product_1", first_product.id
    assert_equal "Product One", first_product.name
    assert_equal "image_url_1", first_product.image["src"]
    assert_equal 10.99, first_product.price["vatIncluded"]

    second_product = products.last
    assert_equal "product_2", second_product.id
    assert_equal "Product Two", second_product.name
  end

  def test_get_product_by_id
    stub_request(:post, @endpoint)
      .with(
        body: {
          query: @get_products_query,
          variables: {
            shopId: "12345",
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
            products: {
              items: [
                {
                  id: "product_1",
                  name: "Product One",
                  image: {
                    src: "image_url_1",
                    srcset: "image_srcset_1",
                    altText: "alt_text_1",
                    format: "PNG"
                  },
                  price: {
                    vatExcluded: nil,
                    vatIncluded: 10.99,
                    vatAmount: nil
                  }
                }
              ]
            }
          }
        }.to_json
      )

    product = SpreadshopClient::Product.get_by_id(product_id: "product_1", shop_id: "12345", platform: "test_platform", locale: "en_US")
    assert_instance_of SpreadshopClient::Product, product
    assert_equal "product_1", product.id
    assert_equal "Product One", product.name
    assert_equal "image_url_1", product.image["src"]
    assert_equal 10.99, product.price["vatIncluded"]

    # Test for a non-existent product
    product_not_found = SpreadshopClient::Product.get_by_id(product_id: "nonexistent_product", shop_id: "12345", platform: "test_platform", locale: "en_US")
    assert_instance_of Hash, product_not_found
    assert_equal "Product not found", product_not_found[:error]
  end
end
