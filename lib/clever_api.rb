# frozen_string_literal: true

require "typhoeus"
require "json"

require "clever_api/configuration"
require "clever_api/error"
require "clever_api/authentication"
require "clever_api/sso"
require "clever_api/client"
require "clever_api/version"

module CleverApi
  class << self
    attr_writer :configuration
  end

  def self.configure
    yield(configuration)
  end

  def self.configuration
    @configuration ||= CleverApi::Configuration.new
  end

  def self.authentication(configuration = CleverApi.configuration)
    yield configuration if block_given?

    CleverApi::Authentication.new(configuration)
  end

  def self.client(access_token, configuration = CleverApi.configuration)
    yield configuration if block_given?

    CleverApi::Client.new(access_token, configuration)
  end

  def self.sso(code, configuration = CleverApi.configuration)
    yield configuration if block_given?

    CleverApi::SSO.new(code, configuration)
  end

  def self.sso_redirect_uri(configuration = CleverApi.configuration)
    "https://clever.com/oauth/authorize?response_type=code&redirect_uri=#{configuration.redirect_uri}&client_id=#{configuration.client_id}"
  end
end
