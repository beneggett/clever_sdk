# frozen_string_literal: true

require "clever_sdk/data/events"

module CleverSDK
  class Client
    module Events
      def events(limit: nil, starting_after: nil, ending_before: nil, school: nil, record_type: nil)
        response = api.events(access_token: access_token,
          limit: limit, starting_after: starting_after, ending_before: ending_before,
          school: school, record_type: record_type)
        CleverSDK::Data::Events.new(response)
      end

      def event(id)
        response = api.event(access_token: access_token, id: id)
        data = response.body.dig("data")
        CleverSDK::Data::Event.new(data, response)
      end
    end
  end
end
