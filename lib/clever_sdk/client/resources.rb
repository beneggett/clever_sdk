# frozen_string_literal: true

require "clever_sdk/data/resources"

module CleverSDK
  class Client
    module Resources
      def resources(limit: nil, starting_after: nil, ending_before: nil)
        response = api.resources(access_token: access_token,
          limit: limit, starting_after: starting_after, ending_before: ending_before)
        CleverSDK::Data::Resources.new(response)
      end

      def resource(id)
        response = api.resource(access_token: access_token, id: id)
        data = response.body.dig("data")
        CleverSDK::Data::Resources.new(data, response)
      end

      def resource_courses(id, limit: nil, starting_after: nil, ending_before: nil)
        response = api.resource_courses(access_token: access_token, id: id,
          limit: limit, starting_after: starting_after, ending_before: ending_before)
        CleverSDK::Data::Courses.new(response)
      end

      def resource_sections(id, limit: nil, starting_after: nil, ending_before: nil)
        response = api.resource_sections(access_token: access_token, id: id,
          limit: limit, starting_after: starting_after, ending_before: ending_before)
        CleverSDK::Data::Sections.new(response)
      end

      # role - acceptable values are nil, :student, :teacher
      def resource_users(id, role: nil, limit: nil, starting_after: nil, ending_before: nil)
        response = api.resource_users(access_token: access_token, id: id, role: role,
          limit: limit, starting_after: starting_after, ending_before: ending_before)
        CleverSDK::Data::Users.new(response)
      end
    end
  end
end
