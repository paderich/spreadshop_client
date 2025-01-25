# frozen_string_literal: true

$LOAD_PATH.unshift(File.expand_path("..", __dir__))

require "spreadshop_client/version"
require "spreadshop_client/models/shop"

module SpreadshopClient
  class Error < StandardError; end

  def self.get_shop(name:, platform:, locale:)
    Shop.get_shop(name: name, platform: platform, locale: locale)
  end
end
