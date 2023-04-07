# frozen_string_literal: true

module CleverApi
  class Error < StandardError
    def self.handle(typhoeus_response)
      explanation = CleverApi::Api::Response.status_code_explanations[typhoeus_response.code]

      error_obj = if explanation.nil?
        new
      else
        new([explanation[:meaning], explanation[:action_to_take]].join(": "))
      end

      error_obj.response = typhoeus_response
      error_obj.code = typhoeus_response.code
      error_obj.meaning = explanation[:meaning] if explanation
      error_obj.action_to_take = explanation[:action_to_take] if explanation
      error_obj
    end

    attr_accessor :response, :code, :meaning, :action_to_take

    def intitialize(message = "Unknown API error")
      super(message)
    end
  end
end
