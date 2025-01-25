require_relative "../queries/shop_queries"
require_relative "../client"

module SpreadshopClient
  class Shop
    include SpreadshopClient::Queries::ShopQueries

    attr_reader :id, :name

    def initialize(attributes)
      @id = attributes["id"]
      @name = attributes["name"]
    end

    def self.get_shop(name:, platform:, locale:)
      response = SpreadshopClient::Client.query(GET_SHOP, {name: name, platform: platform, locale: locale})
      if response["data"] && response["data"]["shop"]
        new(response["data"]["shop"])
      else
        {error: response["errors"] || "Unknown error"}
      end
    end
  end
end
