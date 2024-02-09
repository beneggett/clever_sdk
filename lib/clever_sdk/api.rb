# frozen_string_literal: true

require "base64"
require "json"
require "clever_sdk/error"
require "clever_sdk/api/response"
require "clever_sdk/api/authentication"
require "clever_sdk/api/courses"
require "clever_sdk/api/districts"
require "clever_sdk/api/resources"
require "clever_sdk/api/schools"
require "clever_sdk/api/sections"
require "clever_sdk/api/terms"
require "clever_sdk/api/users"
require "clever_sdk/api/events"

module CleverSDK
  ##
  # private
  # CleverSDK::Api is only responsible for making requests to Clever API.
  # CleverSDK::Api is not responsible for managing authentication state.
  # CleverSDK::Api is not responsible for specifying/using configured values.
  # CleverSDK::Api is not responsible for iterating across multiple Clever API requests.
  class Api
    include CleverSDK::Api::Authentication
    include CleverSDK::Api::Courses
    include CleverSDK::Api::Districts
    include CleverSDK::Api::Resources
    include CleverSDK::Api::Schools
    include CleverSDK::Api::Sections
    include CleverSDK::Api::Terms
    include CleverSDK::Api::Users
    include CleverSDK::Api::Events

    # internal
    def page(access_token:, path:)
      get(
        "https://api.clever.com#{path}",
        {},
        bearer_headers(access_token)
      )
    end

    private

    def get url, params = nil, headers = nil
      CleverSDK::Api::Response.handle(
        Faraday.get url, params, headers
      )
    end

    def post url, body = nil, headers = nil
      CleverSDK::Api::Response.handle(
        Faraday.post url, body, headers
      )
    end

    def params **kwargs
      kwargs.delete_if { |_k, v| v.nil? }
    end

    def basic_auth_token(client_id, client_secret)
      Base64.strict_encode64([client_id, client_secret].join(":"))
    end

    def basic_auth_headers(client_id, client_secret)
      {
        "Accept" => "application/json",
        "Authorization" => "Basic #{basic_auth_token(client_id, client_secret)}"
      }
    end

    def bearer_headers(access_token)
      {
        "Accept" => "application/json",
        "Authorization" => "Bearer #{access_token}"
      }
    end
  end
end
