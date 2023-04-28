# frozen_string_literal: true

module CleverSDK
  module Data
    class Term
      class Refs
        # private
        def initialize(term)
          @term = term
        end

        def district
          client.term_district(@term.id)
        end

        def schools(limit: nil, starting_after: nil, ending_before: nil)
          client.term_schools(@term.id, limit: limit, starting_after: starting_after, ending_before: ending_before)
        end

        def sections(limit: nil, starting_after: nil, ending_before: nil)
          client.term_sections(@term.id, limit: limit, starting_after: starting_after, ending_before: ending_before)
        end

        private

        def client
          @client ||= CleverSDK::Client.new(@term.response.access_token)
        end
      end
    end
  end
end
