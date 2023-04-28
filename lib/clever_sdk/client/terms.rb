# frozen_string_literal: true

require "clever_sdk/data/terms"

module CleverSDK
  class Client
    module Terms
      # count - acceptable values are nil, :true, :false, :undefined
      def terms(limit: nil, starting_after: nil, ending_before: nil, count: nil)
        response = api.terms(access_token: access_token,
          limit: limit, starting_after: starting_after, ending_before: ending_before, count: count)
        CleverSDK::Data::Terms.new(response)
      end

      def term(id)
        response = api.term(access_token: access_token, id: id)
        data = response.body.dig("data")
        CleverSDK::Data::Term.new(data, response)
      end

      def term_district(id)
        response = api.term_district(access_token: access_token, id: id)
        data = response.body.dig("data")
        CleverSDK::Data::District.new(data, response)
      end

      def term_schools(id, limit: nil, starting_after: nil, ending_before: nil)
        response = api.term_schools(access_token: access_token, id: id,
          limit: limit, starting_after: starting_after, ending_before: ending_before)
        CleverSDK::Data::Schools.new(response)
      end

      def term_sections(id)
        response = api.term_sections(access_token: access_token, id: id,
          limit: limit, starting_after: starting_after, ending_before: ending_before)
        CleverSDK::Data::Sections.new(response)
      end
    end
  end
end
