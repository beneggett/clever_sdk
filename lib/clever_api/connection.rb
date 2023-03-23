module CleverApi 
  class Connection 

    attr_reader :access_token

    def initialize(access_token = nil)
      @access_token = access_token
    end

    def get(url, params = {})
      request = Typhoeus::Request.new(
        url,
        method: :get,
        params: params,
        headers: self.class.headers(access_token)
      )
      request.run
    end 

    def post(url, body = {})
      request = Typhoeus::Request.new(
        url,
        method: :post,
        body: body,
        headers: self.class.headers(access_token)
      )
      request.run
    end  

    

    class << self 
      
      def status_code_explanations 
        # from https://dev.clever.com/reference/responses-errors
        { 
          200	=> {meaning: "Success", action_to_take:	"Process the response."},
          400	=> {meaning: "Bad request",	action_to_take: "Check your API token and request body. Do not retry request. The troubleshooting pages for each API also have tips for what to look for!"},
          401	=> {meaning: "Invalid auth", action_to_take: 	"Check your API token and request body. Do not retry request. The troubleshooting pages for each API also have tips for what to look for!"},
          404	=> {meaning: "Resource not available", action_to_take:  "Check your API token and request URL - you may be using the wrong token or the resource may have been unshared with your application or deleted."},
          413	=> {meaning: "Request entity too large", action_to_take:  "Your limit parameter may be over 10000; reduce accordingly."},
          429	=> {meaning: "Rate limit exceeded", action_to_take:  "Try again after rate limit period expires."},
          500 => {meaning: "Clever API failure", action_to_take: "Wait and retry request. If you see these regularly, reach out to integrations@clever.com."},
          502 => {meaning: "Clever API failure", action_to_take: "Wait and retry request. If you see these regularly, reach out to integrations@clever.com."},
          503 => {meaning: "Clever API failure", action_to_take: "Wait and retry request. If you see these regularly, reach out to integrations@clever.com."},
          501	=> {meaning: "Not implemented", action_to_take: "Your client is attempting an unsupported request. Try an alternative request. Do not retry request."}
        }
      end

      def basic_auth_get(url, params = {} )
        request = Typhoeus::Request.new(
          url,
          method: :get,
          params: params,
          userpwd: basic_auth,
          headers: headers
        )
        response = request.run
      end
      
      def basic_auth_post(url, params = {} )
        request = Typhoeus::Request.new(
          url,
          method: :post,
          body: params,
          userpwd: basic_auth,
          headers: headers
        )
        response = request.run
      end
      
      # def base_body_params
      #   {
      #     client_id: CleverApi.configuration.client_id,
      #     client_secret: CleverApi.configuration.client_secret
      #   }
      # end

      def basic_auth
        [CleverApi.configuration.client_id,CleverApi.configuration.client_secret].join(":")
      end

      def headers(bearer_access_token= nil) 
        header_params = {'Accept-Header' => 'application/json'}
        if !bearer_access_token.nil? 
          header_params["Authorization"] = "Bearer #{bearer_access_token}"
        end
        header_params
      end

    end
  end
end

# Test Credentials 
# CleverApi.configuration.client_id = "095b82cbbd8c68714d1c"
# CleverApi.configuration.client_secret = "4b338489ceb4bec362461a7c96e3aa609efff049"
# Authorization: "Basic: MDk1YjgyY2JiZDhjNjg3MTRkMWM6NGIzMzg0ODljZWI0YmVjMzYyNDYxYTdjOTZlM2FhNjA5ZWZmZjA0OQ=="

# Identity API Test tokens: 
# ilc_DEMO_STUDENT_TOKEN
# ilc_DEMO_TEACHER_TOKEN
# ilc_DEMO_SCHOOL_ADMIN_TOKEN
# ilc_DEMO_DISTRICT_ADMIN_TOKEN

# Data API test tokens:
# TEST_TOKEN

# Events API test tokens:
# TEST_TOKEN