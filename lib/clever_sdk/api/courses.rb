# frozen_string_literal: true

module CleverSDK
  class Api
    module Courses
      # count - acceptable values are nil, :true, :false, :undefined
      def courses(access_token:, limit: nil, starting_after: nil, ending_before: nil, count: nil)
        get(
          "https://api.clever.com/v3.0/courses",
          params(limit: limit, starting_after: starting_after, ending_before: ending_before, count: count),
          bearer_headers(access_token)
        )
      end

      def course(access_token:, id:)
        get(
          "https://api.clever.com/v3.0/courses/#{id}",
          {},
          bearer_headers(access_token)
        )
      end

      def course_district(access_token:, id:)
        get(
          "https://api.clever.com/v3.0/courses/#{id}/district",
          {},
          bearer_headers(access_token)
        )
      end

      def course_resources(access_token:, id:, limit: nil, starting_after: nil, ending_before: nil)
        get(
          "https://api.clever.com/v3.0/courses/#{id}/resources",
          params(limit: limit, starting_after: starting_after, ending_before: ending_before),
          bearer_headers(access_token)
        )
      end

      def course_schools(access_token:, id:, limit: nil, starting_after: nil, ending_before: nil)
        get(
          "https://api.clever.com/v3.0/courses/#{id}/schools",
          params(limit: limit, starting_after: starting_after, ending_before: ending_before),
          bearer_headers(access_token)
        )
      end

      def course_sections(access_token:, id:, limit: nil, starting_after: nil, ending_before: nil)
        get(
          "https://api.clever.com/v3.0/courses/#{id}/sections",
          params(limit: limit, starting_after: starting_after, ending_before: ending_before),
          bearer_headers(access_token)
        )
      end
    end
  end
end
