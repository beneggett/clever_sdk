# frozen_string_literal: true

module CleverSDK
  class Api
    module Events
      def events(access_token:, limit: nil, starting_after: nil, ending_before: nil, school: nil, record_type: nil)
        record_type = Array(record_type).flatten.compact
        record_type = nil if record_type.empty?

        get(
          "https://api.clever.com/v3.0/events",
          params(limit: limit, starting_after: starting_after, ending_before: ending_before,
            school: school, record_type: record_type),
          bearer_headers(access_token)
        )
      end

      def event(access_token:, id:)
        get(
          "https://api.clever.com/v3.0/events/#{id}",
          {},
          bearer_headers(access_token)
        )
      end
    end
  end
end
