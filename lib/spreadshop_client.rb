# frozen_string_literal: true

$LOAD_PATH.unshift(File.expand_path("..", __dir__))

require "spreadshop_client/version"
require "spreadshop_client/queries/shop_queries"
require "spreadshop_client/models/shop"
require "spreadshop_client/client"

module SpreadshopClient
  class Error < StandardError; end

  def self.get_shop(name:, platform:, locale:)
    query = Queries::ShopQueries::GET_SHOP
    variables = {name: name, platform: platform, locale: locale}
    Client.query(query, variables)
  end

  private_constant :Client
end
