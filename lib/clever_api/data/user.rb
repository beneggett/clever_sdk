# frozen_string_literal: true

module CleverApi
  module Data
    class User
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

      def first_name
        data.dig("name", "first")
      end

      def middle_name
        data.dig("name", "middle")
      end

      def last_name
        data.dig("name", "last")
      end

      def email
        data.dig("email")
      end

      def roles
        data.dig("roles")
      end

      def created
        DateTime.parse(data.dig("created"))
      rescue
        nil
      end

      def last_modified
        DateTime.parse(data.dig("last_modified"))
      rescue
        nil
      end

      def inspect
        "#<#{self.class.name}(#{id}) #{first_name} #{last_name}>"
      end

      alias_method :to_h, :data
    end
  end
end
