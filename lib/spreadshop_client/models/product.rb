require_relative "../client"

module SpreadshopClient
  module Models
    class ProductModel
      include ProductsQueries

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

        # Safely navigate through the response using dig
        items = response.dig("data", "products", "items") || []
        item = items.find { |item| item["id"] == product_id }

        # Return a new instance if found, otherwise return nil
        item ? new(item) : nil
      end
    end
  end
end
