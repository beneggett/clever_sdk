# frozen_string_literal: true

require "clever_api/data/courses"
require "clever_api/data/districts"
require "clever_api/data/schools"
require "clever_api/data/sections"
require "clever_api/data/terms"
require "clever_api/data/users"

module CleverApi
  module Data
    class Event
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

      def type
        data.dig("type")
      end

      def created
        DateTime.parse(data.dig("created"))
      rescue
        nil
      end

      def object
        return object_class.new(object_data, response) if object_class

        object_data
      end

      def previous_attributes
        data.dig("data", "previous_attributes")
      end

      def inspect
        "#<#{self.class.name}(#{id}) #{type}>"
      end

      alias_method :to_h, :data

      private

      def object_type
        # courses
        # districts
        # schools
        # sections
        # terms
        # users
        type.split(".").first
      end

      def object_data
        data.dig("data", "object")
      end

      def object_class
        case object_type
        when "courses"
          CleverApi::Data::Course
        when "districts"
          CleverApi::Data::District
        when "schools"
          CleverApi::Data::School
        when "sections"
          CleverApi::Data::Section
        when "terms"
          CleverApi::Data::Term
        when "users"
          CleverApi::Data::User
        else
          nil
        end
      end

      def object_action
        # created
        # deleted
        # updated
        type.split(".").last
      end
    end
  end
end
