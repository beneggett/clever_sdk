# frozen_string_literal: true

module CleverSDK
  class Api
    module Districts
      # count - acceptable values are nil, :true, :false, :undefined
      def districts(access_token:, count: nil)
        get(
          "https://api.clever.com/v3.0/districts",
          params(count: count),
          bearer_headers(access_token)
        )
      end

      def district(access_token:, id:)
        get(
          "https://api.clever.com/v3.0/districts/#{id}",
          {},
          bearer_headers(access_token)
        )
      end
    end
  end
end
