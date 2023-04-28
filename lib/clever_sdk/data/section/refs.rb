# frozen_string_literal: true

module CleverSDK
  module Data
    class Section
      class Refs
        # private
        def initialize(section)
          @section = section
        end

        def course
          client.section_course(@section.id)
        end

        def district
          client.section_district(@section.id)
        end

        def resources(limit: nil, starting_after: nil, ending_before: nil)
          client.section_resources(@section.id, limit: limit, starting_after: starting_after, ending_before: ending_before)
        end

        def school
          client.section_school(@section.id)
        end

        def term
          client.section_term(@section.id)
        end

        # role - acceptable values are nil, :staff, :student, :teacher
        def users(role: nil, limit: nil, starting_after: nil, ending_before: nil)
          client.section_users(@section.id, role: role, limit: limit, starting_after: starting_after, ending_before: ending_before)
        end

        private

        def client
          @client ||= CleverSDK::Client.new(@section.response.access_token)
        end
      end
    end
  end
end
