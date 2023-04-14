# frozen_string_literal: true

require "clever_api/api"
require "clever_api/data/tokens"

module CleverApi
  class Authentication
    attr_accessor :configuration

    def initialize(configuration = CleverApi.configuration)
      yield configuration if block_given?

      @configuration = configuration
    end

    def tokens
      response = Api.new.tokens(
        client_id: configuration.client_id,
        client_secret: configuration.client_secret
      )
      CleverApi::Data::Tokens.new(response)
    end

    def token(district_id)
      response = Api.new.tokens(
        client_id: configuration.client_id,
        client_secret: configuration.client_secret,
        district: district_id
      )
      data = Array(response.body.dig("data")).first
      CleverApi::Data::Token.new(data, response)
    end

    def tokeninfo(access_token)
      response = Api.new.tokeninfo(access_token: access_token)
      data = response.body.dig("data")
      CleverApi::Data::Token.new(data, response)
    end

    def me(access_token)
      response = Api.new.me(access_token: access_token)
      data = response.body.dig("data")
      CleverApi::Data::Token.new(data, response)
    end

    def inspect
      "#<#{self.class.name}:0x#{(object_id * 2).to_s(16).rjust(16, "0")}>"
    end
  end
end
