# frozen_string_literal: true

module CleverSDK
  module Data
    class Resource
      class Refs
        # private
        def initialize(resource)
          @resource = resource
        end

        def district
          client.course_district(@resource.id)
        end

        def courses(limit: nil, starting_after: nil, ending_before: nil)
          client.resource_courses(@resource.id, limit: limit, starting_after: starting_after, ending_before: ending_before)
        end

        def sections(limit: nil, starting_after: nil, ending_before: nil)
          client.resource_sections(@resource.id, limit: limit, starting_after: starting_after, ending_before: ending_before)
        end

        # role - acceptable values are nil, :student, :teacher
        def users(role: nil, limit: nil, starting_after: nil, ending_before: nil)
          client.resource_users(@resource.id, role: role, limit: limit, starting_after: starting_after, ending_before: ending_before)
        end

        def resource_courses(access_token:, id:, limit: nil, starting_after: nil, ending_before: nil)
          get(
            "https://api.clever.com/v3.0/resources/#{id}/courses",
            params: params(limit: limit, starting_after: starting_after, ending_before: ending_before),
            headers: bearer_headers(access_token)
          )
        end

        private

        def client
          @client ||= CleverSDK::Client.new(@resource.response.access_token)
        end
      end
    end
  end
end
