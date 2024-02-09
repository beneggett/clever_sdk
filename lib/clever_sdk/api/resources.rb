# frozen_string_literal: true

module CleverSDK
  class Api
    module Resources
      def resources(access_token:, limit: nil, starting_after: nil, ending_before: nil)
        get(
          "https://api.clever.com/v3.0/resources",
          params(limit: limit, starting_after: starting_after, ending_before: ending_before),
          bearer_headers(access_token)
        )
      end

      def resource(access_token:, id:)
        get(
          "https://api.clever.com/v3.0/resources/#{id}",
          {},
          bearer_headers(access_token)
        )
      end

      def resource_courses(access_token:, id:, limit: nil, starting_after: nil, ending_before: nil)
        get(
          "https://api.clever.com/v3.0/resources/#{id}/courses",
          params(limit: limit, starting_after: starting_after, ending_before: ending_before),
          bearer_headers(access_token)
        )
      end

      def resource_sections(access_token:, id:, limit: nil, starting_after: nil, ending_before: nil)
        get(
          "https://api.clever.com/v3.0/resources/#{id}/sections",
          params(limit: limit, starting_after: starting_after, ending_before: ending_before),
          bearer_headers(access_token)
        )
      end

      # role - acceptable values are nil, :student, :teacher
      def resource_users(access_token:, id:, role: nil, limit: nil, starting_after: nil, ending_before: nil)
        get(
          "https://api.clever.com/v3.0/resources/#{id}/users",
          params(role: role, limit: limit, starting_after: starting_after, ending_before: ending_before),
          bearer_headers(access_token)
        )
      end
      # def resource_students(access_token:, id:, limit: nil, starting_after: nil, ending_before: nil)
      # def resource_teachers(access_token:, id:, limit: nil, starting_after: nil, ending_before: nil)
    end
  end
end
