# frozen_string_literal: true

require "clever_sdk/data/users"

module CleverSDK
  class Client
    module Users
      # role - acceptable values are nil, :contact, :district_admin, :staff, :student, :teacher
      # count - acceptable values are nil, :true, :false, :undefined
      def users(role: nil, limit: nil, starting_after: nil, ending_before: nil, count: nil)
        response = api.users(access_token: access_token, role: role,
          limit: limit, starting_after: starting_after, ending_before: ending_before, count: count)
        CleverSDK::Data::Users.new(response)
      end

      def user(id)
        response = api.user(access_token: access_token, id: id)
        data = response.body.dig("data")
        CleverSDK::Data::User.new(data, response)
      end

      def user_district(id)
        response = api.user_district(access_token: access_token, id: id)
        data = response.body.dig("data")
        CleverSDK::Data::District.new(data, response)
      end

      def user_resources(id, limit: nil, starting_after: nil, ending_before: nil)
        response = api.user_resources(access_token: access_token, id: id,
          limit: limit, starting_after: starting_after, ending_before: ending_before)
        CleverSDK::Data::Resources.new(response)
      end

      # primary - acceptable values are nil, true
      def user_schools(id, primary: nil, limit: nil, starting_after: nil, ending_before: nil)
        response = api.user_schools(access_token: access_token, id: id, primary: primary,
          limit: limit, starting_after: starting_after, ending_before: ending_before)
        CleverSDK::Data::Schools.new(response)
      end

      def user_sections(id, limit: nil, starting_after: nil, ending_before: nil)
        response = api.user_sections(access_token: access_token, id: id,
          limit: limit, starting_after: starting_after, ending_before: ending_before)
        CleverSDK::Data::Sections.new(response)
      end

      def user_mycontacts(id, limit: nil, starting_after: nil, ending_before: nil)
        response = api.user_mycontacts(access_token: access_token, id: id,
          limit: limit, starting_after: starting_after, ending_before: ending_before)
        CleverSDK::Data::Users.new(response)
      end

      def user_mystudents(id, limit: nil, starting_after: nil, ending_before: nil)
        response = api.user_mystudents(access_token: access_token, id: id,
          limit: limit, starting_after: starting_after, ending_before: ending_before)
        CleverSDK::Data::Users.new(response)
      end

      def user_myteachers(id, limit: nil, starting_after: nil, ending_before: nil)
        response = api.user_myteachers(access_token: access_token, id: id,
          limit: limit, starting_after: starting_after, ending_before: ending_before)
        CleverSDK::Data::Users.new(response)
      end
    end
  end
end
