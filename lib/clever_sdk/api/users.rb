# frozen_string_literal: true

module CleverSDK
  class Api
    module Users
      # role - acceptable values are nil, :contact, :district_admin, :staff, :student, :teacher
      # count - acceptable values are nil, :true, :false, :undefined
      def users(access_token:, role: nil, limit: nil, starting_after: nil, ending_before: nil, count: nil)
        get(
          "https://api.clever.com/v3.0/users",
          params(role: role, limit: limit, starting_after: starting_after, ending_before: ending_before,
            count: count),
          bearer_headers(access_token)
        )
      end

      def user(access_token:, id:)
        get(
          "https://api.clever.com/v3.0/users/#{id}",
          {},
          bearer_headers(access_token)
        )
      end

      def user_district(access_token:, id:)
        get(
          "https://api.clever.com/v3.0/users/#{id}/district",
          {},
          bearer_headers(access_token)
        )
      end

      def user_resources(access_token:, id:, limit: nil, starting_after: nil, ending_before: nil)
        get(
          "https://api.clever.com/v3.0/users/#{id}/resources",
          params(limit: limit, starting_after: starting_after, ending_before: ending_before),
          bearer_headers(access_token)
        )
      end

      # primary - acceptable values are nil, true
      def user_schools(access_token:, id:, primary: nil, limit: nil, starting_after: nil, ending_before: nil)
        get(
          "https://api.clever.com/v3.0/users/#{id}/schools",
          params(primary: primary, limit: limit, starting_after: starting_after, ending_before: ending_before),
          bearer_headers(access_token)
        )
      end

      def user_sections(access_token:, id:, limit: nil, starting_after: nil, ending_before: nil)
        get(
          "https://api.clever.com/v3.0/users/#{id}/sections",
          params(limit: limit, starting_after: starting_after, ending_before: ending_before),
          bearer_headers(access_token)
        )
      end

      def user_mycontacts(access_token:, id:, limit: nil, starting_after: nil, ending_before: nil)
        get(
          "https://api.clever.com/v3.0/users/#{id}/mycontacts",
          params(limit: limit, starting_after: starting_after, ending_before: ending_before),
          bearer_headers(access_token)
        )
      end

      def user_mystudents(access_token:, id:, limit: nil, starting_after: nil, ending_before: nil)
        get(
          "https://api.clever.com/v3.0/users/#{id}/mystudents",
          params(limit: limit, starting_after: starting_after, ending_before: ending_before),
          bearer_headers(access_token)
        )
      end

      def user_myteachers(access_token:, id:, limit: nil, starting_after: nil, ending_before: nil)
        get(
          "https://api.clever.com/v3.0/users/#{id}/myteachers",
          params(limit: limit, starting_after: starting_after, ending_before: ending_before),
          bearer_headers(access_token)
        )
      end
    end
  end
end
