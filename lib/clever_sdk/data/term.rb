# frozen_string_literal: true

module CleverSDK
  module Data
    class Term
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

      def name
        data.dig("name")
      end

      def start_date
        Date.parse(data.dig("start_date"))
      rescue
        nil
      end

      def end_date
        Date.parse(data.dig("end_date"))
      rescue
        nil
      end

      def inspect
        "#<#{self.class.name}(#{id}) #{name}>"
      end

      alias_method :to_h, :data
    end
  end
end
