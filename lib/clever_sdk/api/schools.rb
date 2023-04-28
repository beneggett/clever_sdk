# frozen_string_literal: true

module CleverSDK
  class Api
    module Schools
      # count - acceptable values are nil, :true, :false, :undefined
      def schools(access_token:, limit: nil, starting_after: nil, ending_before: nil, count: nil)
        get(
          "https://api.clever.com/v3.0/schools",
          params: params(limit: limit, starting_after: starting_after, ending_before: ending_before, count: count),
          headers: bearer_headers(access_token)
        )
      end

      def school(access_token:, id:)
        get(
          "https://api.clever.com/v3.0/schools/#{id}",
          headers: bearer_headers(access_token)
        )
      end

      def school_courses(access_token:, id:, limit: nil, starting_after: nil, ending_before: nil)
        get(
          "https://api.clever.com/v3.0/schools/#{id}/courses",
          params: params(limit: limit, starting_after: starting_after, ending_before: ending_before),
          headers: bearer_headers(access_token)
        )
      end

      def school_district(access_token:, id:)
        get(
          "https://api.clever.com/v3.0/schools/#{id}/district",
          headers: bearer_headers(access_token)
        )
      end

      def school_sections(access_token:, id:, limit: nil, starting_after: nil, ending_before: nil)
        get(
          "https://api.clever.com/v3.0/schools/#{id}/sections",
          params: params(limit: limit, starting_after: starting_after, ending_before: ending_before),
          headers: bearer_headers(access_token)
        )
      end

      def school_terms(access_token:, id:, limit: nil, starting_after: nil, ending_before: nil)
        get(
          "https://api.clever.com/v3.0/schools/#{id}/terms",
          params: params(limit: limit, starting_after: starting_after, ending_before: ending_before),
          headers: bearer_headers(access_token)
        )
      end

      # role - acceptable values are nil, :staff, :student, :teacher
      # primary - acceptable values are nil, true
      def school_users(access_token:, id:, role: nil, primary: nil, limit: nil, starting_after: nil, ending_before: nil)
        get(
          "https://api.clever.com/v3.0/schools/#{id}/users",
          params: params(role: role, primary: primary,
            limit: limit, starting_after: starting_after, ending_before: ending_before),
          headers: bearer_headers(access_token)
        )
      end
      # def school_staff(access_token:, id:, primary: nil, limit: nil, starting_after: nil, ending_before: nil)
      # def school_students(access_token:, id:, primary: nil, limit: nil, starting_after: nil, ending_before: nil)
      # def school_teachers(access_token:, id:, primary: nil, limit: nil, starting_after: nil, ending_before: nil)
    end
  end
end
