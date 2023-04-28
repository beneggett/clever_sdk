# frozen_string_literal: true

require "clever_sdk/api"
require "clever_sdk/data/tokens"
require "clever_sdk/data/tokeninfo"
require "clever_sdk/data/me"
require "clever_sdk/data/sso"

module CleverSDK
  class Authentication
    attr_accessor :configuration

    def initialize(configuration = CleverSDK.configuration)
      yield configuration if block_given?

      @configuration = configuration
    end

    def tokens
      response = Api.new.tokens(
        client_id: configuration.client_id,
        client_secret: configuration.client_secret
      )
      CleverSDK::Data::Tokens.new(response)
    end

    def token(district_id)
      response = Api.new.tokens(
        client_id: configuration.client_id,
        client_secret: configuration.client_secret,
        district: district_id
      )
      data = Array(response.body.dig("data")).first
      CleverSDK::Data::Token.new(data, response)
    end

    def tokeninfo(access_token)
      response = Api.new.tokeninfo(access_token: access_token)
      CleverSDK::Data::Tokeninfo.new(response.body, response)
    end

    def me(access_token)
      response = Api.new.me(access_token: access_token)
      data = response.body.dig("data")
      CleverSDK::Data::Me.new(data, response)
    end

    def sso(code)
      response = Api.new.tokens!(
        code: code,
        grant_type: "authorization_code",
        client_id: configuration.client_id,
        client_secret: configuration.client_secret,
        redirect_uri: configuration.redirect_uri
      )
      CleverSDK::Data::SSO.new(code, response)
    end

    def sso_redirect_uri
      "https://clever.com/oauth/authorize?response_type=code&redirect_uri=#{configuration.redirect_uri}&client_id=#{configuration.client_id}"
    end

    def inspect
      "#<#{self.class.name}:0x#{(object_id * 2).to_s(16).rjust(16, "0")}>"
    end
  end
end
