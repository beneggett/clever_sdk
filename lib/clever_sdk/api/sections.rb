# frozen_string_literal: true

module CleverSDK
  class Api
    module Sections
      # count - acceptable values are nil, :true, :false, :undefined
      def sections(access_token:, limit: nil, starting_after: nil, ending_before: nil, count: nil)
        get(
          "https://api.clever.com/v3.0/sections",
          params(limit: limit, starting_after: starting_after, ending_before: ending_before, count: count),
          bearer_headers(access_token)
        )
      end

      def section(access_token:, id:)
        get(
          "https://api.clever.com/v3.0/sections/#{id}",
          {},
          bearer_headers(access_token)
        )
      end

      def section_course(access_token:, id:)
        get(
          "https://api.clever.com/v3.0/sections/#{id}/course",
          {},
          bearer_headers(access_token)
        )
      end

      def section_district(access_token:, id:)
        get(
          "https://api.clever.com/v3.0/sections/#{id}/district",
          {},
          bearer_headers(access_token)
        )
      end

      def section_resources(access_token:, id:, limit: nil, starting_after: nil, ending_before: nil)
        get(
          "https://api.clever.com/v3.0/sections/#{id}/resources",
          params(limit: limit, starting_after: starting_after, ending_before: ending_before),
          bearer_headers(access_token)
        )
      end

      def section_school(access_token:, id:)
        get(
          "https://api.clever.com/v3.0/sections/#{id}/school",
          {},
          bearer_headers(access_token)
        )
      end

      def section_term(access_token:, id:)
        get(
          "https://api.clever.com/v3.0/sections/#{id}/term",
          {},
          bearer_headers(access_token)
        )
      end

      # role - acceptable values are nil, :student, :teacher
      def section_users(access_token:, id:, role: nil, limit: nil, starting_after: nil, ending_before: nil)
        get(
          "https://api.clever.com/v3.0/sections/#{id}/users",
          params(role: role, limit: limit, starting_after: starting_after, ending_before: ending_before),
          bearer_headers(access_token)
        )
      end
      # def section_students(access_token:, id:, limit: nil, starting_after: nil, ending_before: nil)
      # def section_teachers(access_token:, id:, limit: nil, starting_after: nil, ending_before: nil)
    end
  end
end
