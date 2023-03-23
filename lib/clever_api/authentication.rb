module CleverApi 
  class Authentication 

    attr_reader :access_token, :token

    def initialize(token =  nil)
      if token && access_token.nil? 
        @token = token 
        set_access_token
      end
    end
    
    def token_data
      self.class.tokens.detect {|token_data| token_data.owner_id == token }
    end

    def self.get_access_token_from_code(code)
      response = CleverApi::Connection.basic_auth_post "https://clever.com/oauth/tokens", {code: code, grant_type: "authorization_code", redirect_uri: CleverApi.configuration.redirect_uri}
      if response.success?
        json = JSON::parse response.body
        json.dig('data').map do |token_data| 
          CleverApi::Data::Token.new token_data 
        end
      end
    end

    def self.token(token_id)
      response = CleverApi::Connection.basic_auth_get "https://clever.com/oauth/tokens", {district: token_id}
      if response.success? 
        json = JSON::parse response.body
        json.dig('data').map do |token_data| 
          CleverApi::Data::Token.new token_data 
        end
      end
    end

    def self.tokens 
      @tokens ||= begin 
        response = CleverApi::Connection.basic_auth_get "https://clever.com/oauth/tokens"
        if response.success? 
          json = JSON::parse response.body
          json.dig('data').map do |token_data| 
            CleverApi::Data::Token.new token_data 
          end
        end 
      end
    end

    private 

    def set_access_token
      if valid_token? 
        @access_token = token_data.access_token
      end
    end

    def valid_token?
      !!token_data
    end

  end
end