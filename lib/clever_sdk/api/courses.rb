# frozen_string_literal: true

module CleverSDK
  class Api
    module Courses
      # count - acceptable values are nil, :true, :false, :undefined
      def courses(access_token:, limit: nil, starting_after: nil, ending_before: nil, count: nil)
        get(
          "https://api.clever.com/v3.0/courses",
          params: params(limit: limit, starting_after: starting_after, ending_before: ending_before, count: count),
          headers: bearer_headers(access_token)
        )
      end

      def course(access_token:, id:)
        get(
          "https://api.clever.com/v3.0/courses/#{id}",
          headers: bearer_headers(access_token)
        )
      end

      def course_district(access_token:, id:)
        get(
          "https://api.clever.com/v3.0/courses/#{id}/district",
          headers: bearer_headers(access_token)
        )
      end

      def course_resources(access_token:, id:, limit: nil, starting_after: nil, ending_before: nil)
        get(
          "https://api.clever.com/v3.0/courses/#{id}/resources",
          params: params(limit: limit, starting_after: starting_after, ending_before: ending_before),
          headers: bearer_headers(access_token)
        )
      end

      def course_schools(access_token:, id:, limit: nil, starting_after: nil, ending_before: nil)
        get(
          "https://api.clever.com/v3.0/courses/#{id}/schools",
          params: params(limit: limit, starting_after: starting_after, ending_before: ending_before),
          headers: bearer_headers(access_token)
        )
      end

      def course_sections(access_token:, id:, limit: nil, starting_after: nil, ending_before: nil)
        get(
          "https://api.clever.com/v3.0/courses/#{id}/sections",
          params: params(limit: limit, starting_after: starting_after, ending_before: ending_before),
          headers: bearer_headers(access_token)
        )
      end
    end
  end
end
