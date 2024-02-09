# frozen_string_literal: true

require "faraday"
require "json"

require "clever_sdk/configuration"
require "clever_sdk/error"
require "clever_sdk/authentication"
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
end
