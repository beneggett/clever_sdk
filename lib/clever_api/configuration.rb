# frozen_string_literal: true

module CleverApi
  class Configuration
    attr_accessor :client_id, :client_secret, :redirect_uri

    def initialize(options = {})
      @client_id = options.dig(:client_id) || ENV["CLEVER_ID"]
      @client_secret = options.dig(:client_secret) || ENV["CLEVER_SECRET"]
      @redirect_uri = options.dig(:redirect_uri) || ENV["CLEVER_REDIRECT_URI"]
    end
  end
end
