# frozen_string_literal: true

module CleverSDK
  module Data
    class Tokeninfo
      # private
      attr_reader :data, :response

      # private
      def initialize(data, response)
        @data = data
        @response = response
      end

      def client_id
        data.dig("client_id")
      end

      def scopes
        data.dig("scopes")
      end

      def inspect
        "#<#{self.class.name}(#{client_id}) #{access_token}>"
      end

      alias_method :to_h, :data
    end
  end
end
