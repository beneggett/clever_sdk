# frozen_string_literal: true

require "clever_sdk/data/courses"

module CleverSDK
  class Client
    module Courses
      # count - acceptable values are nil, :true, :false, :undefined
      def courses(limit: nil, starting_after: nil, ending_before: nil, count: nil)
        response = api.courses(access_token: access_token,
          limit: limit, starting_after: starting_after, ending_before: ending_before, count: count)
        CleverSDK::Data::Courses.new(response)
      end

      def course(id)
        response = api.course(access_token: access_token, id: id)
        data = response.body.dig("data")
        CleverSDK::Data::Course.new(data, response)
      end

      def course_district(id)
        response = api.course_district(access_token: access_token, id: id)
        CleverSDK::Data::District.new(response.body.dig("data"), response)
      end

      def course_resources(id, limit: nil, starting_after: nil, ending_before: nil)
        response = api.course_resources(access_token: access_token, id: id,
          limit: limit, starting_after: starting_after, ending_before: ending_before)
        CleverSDK::Data::Resources.new(response)
      end

      def course_schools(id, limit: nil, starting_after: nil, ending_before: nil)
        response = api.course_schools(access_token: access_token, id: id,
          limit: limit, starting_after: starting_after, ending_before: ending_before)
        CleverSDK::Data::Schools.new(response)
      end

      def course_sections(id, limit: nil, starting_after: nil, ending_before: nil)
        response = api.course_sections(access_token: access_token, id: id,
          limit: limit, starting_after: starting_after, ending_before: ending_before)
        CleverSDK::Data::Sections.new(response)
      end
    end
  end
end
