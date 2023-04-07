# frozen_string_literal: true

module CleverApi
  class Api
    class Response
      def self.handle(typhoeus_response)
        return CleverApi::Api::Response.new(typhoeus_response) if typhoeus_response.success?

        raise CleverApi::Error.handle(typhoeus_response)
      end

      def self.status_code_explanations
        # from https://dev.clever.com/reference/responses-errors
        @status_code_explanations ||= {
          200	=> {meaning: "Success", action_to_take:	"Process the response."},
          400	=> {meaning: "Bad request",	action_to_take: "Check your API token and request body. Do not retry request. The troubleshooting pages for each API also have tips for what to look for!"},
          401	=> {meaning: "Invalid auth", action_to_take:	"Check your API token and request body. Do not retry request. The troubleshooting pages for each API also have tips for what to look for!"},
          404	=> {meaning: "Resource not available", action_to_take: "Check your API token and request URL - you may be using the wrong token or the resource may have been unshared with your application or deleted."},
          413	=> {meaning: "Request entity too large", action_to_take: "Your limit parameter may be over 10000; reduce accordingly."},
          429	=> {meaning: "Rate limit exceeded", action_to_take: "Try again after rate limit period expires."},
          500 => {meaning: "Clever API failure", action_to_take: "Wait and retry request. If you see these regularly, reach out to integrations@clever.com."},
          502 => {meaning: "Clever API failure", action_to_take: "Wait and retry request. If you see these regularly, reach out to integrations@clever.com."},
          503 => {meaning: "Clever API failure", action_to_take: "Wait and retry request. If you see these regularly, reach out to integrations@clever.com."},
          501	=> {meaning: "Not implemented", action_to_take: "Your client is attempting an unsupported request. Try an alternative request. Do not retry request."}
        }
      end

      def initialize(typhoeus_response)
        @_response = typhoeus_response
      end

      def raw_request
        @_response.request
      end

      def raw_response
        @_response
      end

      def code
        @_response.code
      end

      def headers
        @_response.headers
      end

      def body
        # Any response that does not return JSON is handled as an error.
        @body ||= JSON.parse(@_response.body)
      end

      def access_token
        # Dig the access token out of the response object.
        @_response.request.options.dig(:headers, "Authorization").split(" ").last
      end
    end
  end
end
