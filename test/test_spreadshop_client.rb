# frozen_string_literal: true

require "test_helper"

class TestSpreadshopClient < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::SpreadshopClient::VERSION
  end

  def test_client_is_not_accessible
    assert_raises(NameError) { SpreadshopClient::Client }
  end
end
