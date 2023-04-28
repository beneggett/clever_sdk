# frozen_string_literal: true

require "clever_sdk/data/schools"

module CleverSDK
  class Client
    module Schools
      # count - acceptable values are nil, :true, :false, :undefined
      def schools(limit: nil, starting_after: nil, ending_before: nil, count: nil)
        response = api.schools(access_token: access_token,
          limit: limit, starting_after: starting_after, ending_before: ending_before, count: count)
        CleverSDK::Data::Schools.new(response)
      end

      def school(id)
        response = api.school(access_token: access_token, id: id)
        data = response.body.dig("data")
        CleverSDK::Data::School.new(data, response)
      end

      def school_courses(id, limit: nil, starting_after: nil, ending_before: nil)
        response = api.school_courses(access_token: access_token, id: id,
          limit: limit, starting_after: starting_after, ending_before: ending_before)
        CleverSDK::Data::Courses.new(response)
      end

      def school_district(id)
        response = api.school_district(access_token: access_token, id: id)
        data = response.body.dig("data")
        CleverSDK::Data::District.new(data, response)
      end

      def school_sections(id, limit: nil, starting_after: nil, ending_before: nil)
        response = api.school_sections(access_token: access_token, id: id,
          limit: limit, starting_after: starting_after, ending_before: ending_before)
        CleverSDK::Data::Sections.new(response)
      end

      def school_terms(id, limit: nil, starting_after: nil, ending_before: nil)
        response = api.school_terms(access_token: access_token, id: id,
          limit: limit, starting_after: starting_after, ending_before: ending_before)
        CleverSDK::Data::Terms.new(response)
      end

      # role - acceptable values are nil, :staff, :student, :teacher
      # primary - acceptable values are nil, true
      def school_users(id, role: nil, primary: nil, limit: nil, starting_after: nil, ending_before: nil)
        response = api.school_users(access_token: access_token, id: id, role: role, primary: primary,
          limit: limit, starting_after: starting_after, ending_before: ending_before)
        CleverSDK::Data::Users.new(response)
      end
    end
  end
end
