require_relative "../queries/products_queries"
require_relative "../client"

module SpreadshopClient
  class Product
    include SpreadshopClient::Queries::ProductsQueries

    attr_reader :id, :name, :image, :price

    def initialize(attributes)
      @id = attributes["id"]
      @name = attributes["name"]
      @image = attributes["image"] || {}
      @price = attributes["price"] || {}
    end

    def self.get_all(shop_id:, platform:, locale:)
      response = SpreadshopClient::Client.query(GET_PRODUCTS, {shopId: shop_id, platform: platform, locale: locale})

      if response["data"] && response["data"]["products"]
        response["data"]["products"]["items"].map { |item| new(item) }
      else
        {error: response["errors"] || "Unknown error"}
      end
    end

    def self.get_by_id(product_id:, shop_id:, platform:, locale:)
      response = SpreadshopClient::Client.query(GET_PRODUCTS, {shopId: shop_id, platform: platform, locale: locale})

      if response["data"] && response["data"]["products"]
        item = response["data"]["products"]["items"].find { |item| item["id"] == product_id }
        item ? new(item) : {error: "Product not found"}
      else
        {error: response["errors"] || "Unknown error"}
      end
    end
  end
end
