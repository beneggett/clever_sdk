# frozen_string_literal: true

module CleverSDK
  module Data
    ##
    # Represents the data returned from a successful call to CleverSDK::Authentication#sso.
    class SSO
      # public
      attr_reader :code
      # private
      attr_reader :response

      # private
      def initialize(code, response)
        @code = code
        @response = response
      end

      def access_token
        response.body.dig("access_token")
      end

      def token_type
        response.body.dig("token_type")
      end

      def me
        @me ||= CleverSDK.authentication.me(access_token)
      end

      def user
        @user ||= CleverSDK.client(access_token).user(me.id)
      end

      def inspect
        "#<#{self.class.name}(#{code}) #{access_token}>"
      end

      def to_h
        response.body.merge("code" => code, "me" => @me, "user" => @user).delete_if {|_k, v| v.nil?}
      end
    end
  end
end
