require "typhoeus"
require "json"

require "clever_api/authentication"
require "clever_api/connection"

require 'clever_api/data/token'

require "clever_api/version"

module CleverApi

  class << self
    attr_accessor :configuration
  end

  def self.configure
    @configuration ||= Configuration.new
    yield(configuration)
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  class Configuration
    attr_accessor :client_id, :client_secret, :redirect_uri

    def initialize(options= {})
      @client_id = options.dig(:client_id) || ENV["CLEVER_ID"]
      @client_secret = options.dig(:client_secret) || ENV["CLEVER_SECRET"]
      @redirect_uri = options.dig(:redirect_uri) || ENV["CLEVER_REDIRECT_URI"]
    end

  end

end
