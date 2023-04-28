# frozen_string_literal: true

module CleverSDK
  module Data
    class Me
      # private
      attr_reader :data, :response

      # private
      def initialize(data, response)
        @data = data
        @response = response
      end

      def id
        data.dig("id")
      end

      def district
        data.dig("district")
      end

      def type
        data.dig("type")
      end

      def inspect
        "#<#{self.class.name}(#{id}:#{type})>"
      end

      alias_method :to_h, :data
    end
  end
end
