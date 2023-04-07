# frozen_string_literal: true

module CleverApi
  module Data
    class School
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

      def sis_id
        data.dig("sis_id")
      end

      def low_grade
        data.dig("low_grade")
      end

      def high_grade
        data.dig("high_grade")
      end

      def school_number
        data.dig("school_number")
      end

      def principal
        data.dig("principal")
      end

      def state_id
        data.dig("state_id")
      end

      def phone
        data.dig("phone")
      end

      def ext
        data.dig("ext")
      end

      def location
        data.dig("location")
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
        "#<#{self.class.name}(#{id}) #{name}>"
      end

      alias_method :to_h, :data
    end
  end
end
