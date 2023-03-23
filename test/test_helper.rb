require 'dotenv'
Dotenv.load

require 'simplecov'
require 'pry'
require 'coveralls'

Coveralls.wear!

SimpleCov.formatters = [
  Coveralls::SimpleCov::Formatter,
  SimpleCov::Formatter::HTMLFormatter,
]

SimpleCov.start do
  skip_token 'skip_test_coverage'
end

$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "clever_api"

require "minitest/autorun"

