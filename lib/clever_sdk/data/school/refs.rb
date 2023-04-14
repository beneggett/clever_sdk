# frozen_string_literal: true

module CleverSDK
  module Data
    class School
      class Refs
        # private
        def initialize(school)
          @school = school
        end

        def courses(limit: nil, starting_after: nil, ending_before: nil)
          client.school_courses(@school.id, limit: limit, starting_after: starting_after, ending_before: ending_before)
        end

        def district
          client.school_district(@school.id)
        end

        def sections(limit: nil, starting_after: nil, ending_before: nil)
          client.school_sections(@school.id, limit: limit, starting_after: starting_after, ending_before: ending_before)
        end

        def terms(limit: nil, starting_after: nil, ending_before: nil)
          client.school_terms(@school.id, limit: limit, starting_after: starting_after, ending_before: ending_before)
        end

        # role - acceptable values are nil, :staff, :student, :teacher
        # primary - acceptable values are nil, true
        def users(role: nil, primary: nil, limit: nil, starting_after: nil, ending_before: nil)
          client.school_users(@school.id, role: role, primary: primary, limit: limit, starting_after: starting_after, ending_before: ending_before)
        end

        private

        def client
          @client ||= CleverSDK::Client.new(@school.response.access_token)
        end
      end
    end
  end
end
