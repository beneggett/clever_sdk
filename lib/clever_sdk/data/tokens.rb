# frozen_string_literal: true

require "clever_sdk/data/token"

module CleverSDK
  module Data
    class Tokens
      include Enumerable

      # private
      attr_reader :response

      # private
      def initialize(response)
        @response = response
      end

      def data
        @data ||= Array(response.body.dig("data"))
      end

      def each &block
        return enum_for :each unless block

        tokens = Array(data).lazy.map { |datum| CleverSDK::Data::Token.new(datum, response) }
        tokens.each(&block)
      end
      alias_method :all, :each

      def inspect
        "#<#{self.class.name}:0x#{(object_id * 2).to_s(16).rjust(16, "0")} tokens:#{data.count}>"
      end
    end
  end
end
