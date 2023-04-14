# frozen_string_literal: true

require "clever_sdk/api"

module CleverSDK
  class SSO
    attr_reader :code, :access_token, :user
    attr_accessor :configuration

    # the whole reason of this SSO is to take a code and get an access token from it, then use that access token to retrieve user details.
    def initialize(code, configuration = CleverSDK.configuration)
      yield configuration if block_given?
      @configuration = configuration
      @code = code.to_s
    end

    def call
      @access_token = convert_code_to_access_token!
      @user = user_details_from_access_token(access_token)
      self
    end

    def to_h
      {
        code: code,
        access_token: access_token,
        user: user.to_h
      }
    end

    def inspect
      "#<#{self.class.name}:0x#{(object_id * 2).to_s(16).rjust(16, "0")} user=#{!!user}>"
    end

    private

    def convert_code_to_access_token!
      response = Api.new.tokens!(
        code: code,
        client_id: configuration.client_id,
        client_secret: configuration.client_secret,
        redirect_uri: configuration.redirect_uri,
        grant_type: "authorization_code"
      )
      response.body.dig("access_token")
    end

    # Code is a one-time use object, if it's already been checked, it is no longer valid to check again. Guidance suggests storing {code => access_token} locally and checking before
    def user_details_from_access_token(access_token)
      me_response = CleverSDK.authentication(configuration).me(access_token)
      user_id = me_response.id

      CleverSDK.client(access_token).user(user_id)
    end
  end
end
