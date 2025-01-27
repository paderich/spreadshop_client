# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path("../lib", __dir__)
require "spreadshop_client"

require "minitest/autorun"

require "webmock/minitest"

# Enable WebMock
WebMock.enable!
