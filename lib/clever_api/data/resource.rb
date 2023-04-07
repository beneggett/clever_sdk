# frozen_string_literal: true

module CleverApi
  module Data
    class Resource
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

      def resource_id
        data.dig("resource_id")
      end

      def district
        data.dig("district")
      end

      def title
        data.dig("title")
      end

      def roles
        data.dig("roles")
      end

      def created
        DateTime.parse(data.dig("created"))
      rescue
        nil
      end

      def updated
        DateTime.parse(data.dig("updated"))
      rescue
        nil
      end

      def inspect
        "#<#{self.class.name}(#{id}) #{title}>"
      end

      alias_method :to_h, :data
    end
  end
end
