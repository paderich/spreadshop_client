# frozen_string_literal: true

$LOAD_PATH.unshift(File.expand_path("..", __dir__))

require "spreadshop_client/version"
require "spreadshop_client/models/shop_queries"
require "spreadshop_client/models/product_queries"
require "spreadshop_client/models/shop"
require "spreadshop_client/models/product"

module SpreadshopClient
  class Error < StandardError; end

  module Shop
    def self.get_shop(name:, platform:, locale:)
      SpreadshopClient::Models::ShopModel.get_shop(name: name, platform: platform, locale: locale)
    end
  end

  module Product
    def self.get_all(shop_id:, platform:, locale:)
      SpreadshopClient::Models::ProductModel.get_all(shop_id: shop_id, platform: platform, locale: locale)
    end

    def self.get_by_id(product_id:, shop_id:, platform:, locale:)
      SpreadshopClient::Models::ProductModel.get_by_id(product_id: product_id, shop_id: shop_id, platform: platform, locale: locale)
    end
  end
end
