# frozen_string_literal: true

require "clever_sdk/data/sections"

module CleverSDK
  class Client
    module Sections
      # count - acceptable values are nil, :true, :false, :undefined
      def sections(limit: nil, starting_after: nil, ending_before: nil, count: nil)
        response = api.sections(access_token: access_token,
          limit: limit, starting_after: starting_after, ending_before: ending_before, count: count)
        CleverSDK::Data::Sections.new(response)
      end

      def section(id)
        response = api.section(access_token: access_token, id: id)
        data = response.body.dig("data")
        CleverSDK::Data::Section.new(data, response)
      end

      def section_course(id)
        response = api.section_course(access_token: access_token, id: id)
        data = response.body.dig("data")
        CleverSDK::Data::Course.new(data, response)
      end

      def section_district(id)
        response = api.section_district(access_token: access_token, id: id)
        data = response.body.dig("data")
        CleverSDK::Data::District.new(data, response)
      end

      def section_resources(id, limit: nil, starting_after: nil, ending_before: nil)
        response = api.section_resources(access_token: access_token, id: id,
          limit: limit, starting_after: starting_after, ending_before: ending_before)
        CleverSDK::Data::Resources.new(response)
      end

      def section_school(id)
        response = api.section_district(access_token: access_token, id: id)
        data = response.body.dig("data")
        CleverSDK::Data::School.new(data, response)
      end

      def section_term(id)
        response = api.section_district(access_token: access_token, id: id)
        data = response.body.dig("data")
        CleverSDK::Data::Term.new(data, response)
      end

      # role - acceptable values are nil, :student, :teacher
      def section_users(id, role: nil, limit: nil, starting_after: nil, ending_before: nil)
        response = api.section_users(access_token: access_token, id: id, role: role,
          limit: limit, starting_after: starting_after, ending_before: ending_before)
        CleverSDK::Data::Users.new(response)
      end
    end
  end
end
