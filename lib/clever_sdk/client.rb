# frozen_string_literal: true

require "clever_sdk/api"
require "clever_sdk/client/courses"
require "clever_sdk/client/districts"
require "clever_sdk/client/resources"
require "clever_sdk/client/schools"
require "clever_sdk/client/sections"
require "clever_sdk/client/terms"
require "clever_sdk/client/users"
require "clever_sdk/client/events"

module CleverSDK
  class Client
    include CleverSDK::Client::Courses
    include CleverSDK::Client::Districts
    include CleverSDK::Client::Resources
    include CleverSDK::Client::Schools
    include CleverSDK::Client::Sections
    include CleverSDK::Client::Terms
    include CleverSDK::Client::Users
    include CleverSDK::Client::Events

    attr_accessor :access_token, :configuration

    def initialize(access_token, configuration = CleverSDK.configuration)
      @access_token = access_token
      @configuration = configuration
    end

    def inspect
      "#<#{self.class.name}:0x#{(object_id * 2).to_s(16).rjust(16, "0")} #{access_token}>"
    end

    private

    def api
      @api ||= CleverSDK::Api.new
    end
  end
end
