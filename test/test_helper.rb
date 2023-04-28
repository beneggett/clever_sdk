require "dotenv"
Dotenv.load

# require "simplecov"
# require "pry"
# require "coveralls"

# Coveralls.wear!

# SimpleCov.formatters = [
#   Coveralls::SimpleCov::Formatter,
#   SimpleCov::Formatter::HTMLFormatter
# ]

# SimpleCov.start do
#   skip_token "skip_test_coverage"
# end

require "vcr"

VCR.configure do |config|
  config.cassette_library_dir = "test/vcr/cassettes"
  config.hook_into :typhoeus
end

$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "clever_sdk"

require "minitest"
require "minitest/focus"

class CleverSDK::Test < Minitest::Test
  def setup
    CleverSDK.configure do |config|
      # Test Credentials from https://dev.clever.com/reference/schema#schema
      config.client_id = "095b82cbbd8c68714d1c"
      config.client_secret = "4b338489ceb4bec362461a7c96e3aa609efff049"
      config.redirect_uri = "http://localhost:3000/auth/clever"
    end

    super
  end
end

require "minitest/autorun"
