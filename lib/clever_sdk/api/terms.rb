# frozen_string_literal: true

module CleverSDK
  class Api
    module Terms
      # count - acceptable values are nil, :true, :false, :undefined
      def terms(access_token:, limit: nil, starting_after: nil, ending_before: nil, count: nil)
        get(
          "https://api.clever.com/v3.0/terms",
          params(limit: limit, starting_after: starting_after, ending_before: ending_before, count: count),
          bearer_headers(access_token)
        )
      end

      def term(access_token:, id:)
        get(
          "https://api.clever.com/v3.0/terms/#{id}",
          {},
          bearer_headers(access_token)
        )
      end

      def term_district(access_token:, id:)
        get(
          "https://api.clever.com/v3.0/terms/#{id}/district",
          {},
          bearer_headers(access_token)
        )
      end

      def term_schools(access_token:, id:, limit: nil, starting_after: nil, ending_before: nil)
        get(
          "https://api.clever.com/v3.0/terms/#{id}/schools",
          params(limit: limit, starting_after: starting_after, ending_before: ending_before),
          bearer_headers(access_token)
        )
      end

      def term_sections(access_token:, id:, limit: nil, starting_after: nil, ending_before: nil)
        get(
          "https://api.clever.com/v3.0/terms/#{id}/sections",
          params(limit: limit, starting_after: starting_after, ending_before: ending_before),
          bearer_headers(access_token)
        )
      end
    end
  end
end
