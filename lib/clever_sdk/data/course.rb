# frozen_string_literal: true

require "clever_sdk/data/course/refs"

module CleverSDK
  module Data
    class Course
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

      def number
        data.dig("number")
      end

      def refs
        @refs ||= CleverSDK::Data::Course::Refs.new(self)
      end

      def inspect
        "#<#{self.class.name}(#{id}) #{first_name} #{last_name}>"
      end

      alias_method :to_h, :data
    end
  end
end
