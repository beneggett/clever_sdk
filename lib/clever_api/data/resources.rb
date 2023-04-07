# frozen_string_literal: true

require "clever_api/data/resource"

module CleverApi
  module Data
    class Resources
      include Enumerable

      # private
      attr_reader :response

      # private
      def initialize(response)
        @response = response
      end

      def resources
        Array(response.body.dig("resources"))
      end
      alias_method :to_a, :resources

      def each &block
        return enum_for :each unless block

        resources
          .lazy
          .map { |resource| CleverApi::Data::Resource.new(resource, response) }
          .each(&block)
      end

      def next?
        link = find_link("next")
        !link.nil?
      end

      def next
        link = find_link("next")

        return nil if link.nil?

        self.class.new(CleverApi::Api.new.page(path: link.dig("uri"), access_token: response.access_token))
      end

      def prev?
        link = find_link("prev")
        !link.nil?
      end

      def prev
        link = find_link("prev")

        return nil if link.nil?

        self.class.new(CleverApi::Api.new.page(path: link.dig("uri"), access_token: response.access_token))
      end

      def inspect
        "#<#{self.class.name}:0x#{(object_id * 2).to_s(16).rjust(16, "0")} resources:#{resources.count}>"
      end

      private

      def find_link rel
        Array(response.body.dig("links")).find { |link| link.dig("rel") == rel }
      end
    end
  end
end
