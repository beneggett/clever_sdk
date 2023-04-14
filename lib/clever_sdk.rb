# frozen_string_literal: true

require "typhoeus"
require "json"

require "clever_sdk/configuration"
require "clever_sdk/error"
require "clever_sdk/authentication"
require "clever_sdk/sso"
require "clever_sdk/client"
require "clever_sdk/version"

module CleverSDK
  class << self
    attr_writer :configuration
  end

  def self.configure
    yield(configuration)
  end

  def self.configuration
    @configuration ||= CleverSDK::Configuration.new
  end

  def self.authentication(configuration = CleverSDK.configuration)
    yield configuration if block_given?

    CleverSDK::Authentication.new(configuration)
  end

  def self.client(access_token, configuration = CleverSDK.configuration)
    yield configuration if block_given?

    CleverSDK::Client.new(access_token, configuration)
  end

  def self.sso(code, configuration = CleverSDK.configuration)
    yield configuration if block_given?

    CleverSDK::SSO.new(code, configuration)
  end

  def self.sso_redirect_uri(configuration = CleverSDK.configuration)
    "https://clever.com/oauth/authorize?response_type=code&redirect_uri=#{configuration.redirect_uri}&client_id=#{configuration.client_id}"
  end
end
