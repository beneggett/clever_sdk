# frozen_string_literal: true

module CleverSDK
  module Data
    class User
      class Refs
        # private
        def initialize(user)
          @user = user
        end

        def district
          client.user_district(@user.id)
        end

        def resources(limit: nil, starting_after: nil, ending_before: nil)
          client.user_resources(@user.id, limit: limit, starting_after: starting_after, ending_before: ending_before)
        end

        # primary - acceptable values are nil, true
        def schools(primary: nil, limit: nil, starting_after: nil, ending_before: nil)
          client.user_schools(@user.id, primary: primary,
            limit: limit, starting_after: starting_after, ending_before: ending_before)
        end

        def sections(limit: nil, starting_after: nil, ending_before: nil)
          client.user_sections(@user.id, limit: limit, starting_after: starting_after, ending_before: ending_before)
        end

        def mycontacts(limit: nil, starting_after: nil, ending_before: nil)
          return unless @user.student?

          client.user_mycontacts(@user.id, limit: limit, starting_after: starting_after, ending_before: ending_before)
        end

        def mystudents(limit: nil, starting_after: nil, ending_before: nil)
          return unless @user.teacher?

          client.user_mystudents(@user.id, limit: limit, starting_after: starting_after, ending_before: ending_before)
        end

        def myteachers(limit: nil, starting_after: nil, ending_before: nil)
          return unless @user.student?

          client.user_myteachers(@user.id, limit: limit, starting_after: starting_after, ending_before: ending_before)
        end

        private

        def client
          @client ||= CleverSDK::Client.new(@user.response.access_token)
        end
      end
    end
  end
end
