# frozen_string_literal: true

module CleverSDK
  class Api
    module Authentication
      # district - the district's token
      def tokens(client_id:, client_secret:, district: nil)
        get(
          "https://clever.com/oauth/tokens",
          params: params(owner_type: :district, district: district),
          headers: basic_auth_headers(client_id, client_secret)
        )
      end

      def tokens!(client_id:, client_secret:, code: nil, grant_type: nil, redirect_uri: nil)
        post(
          "https://clever.com/oauth/tokens",
          body: JSON.dump(params(code: code, grant_type: grant_type, redirect_uri: redirect_uri)),
          headers: basic_auth_headers(client_id, client_secret).merge({"Content-Type" => "application/json"})
        )
      end

      def tokeninfo(access_token:)
        get(
          "https://clever.com/oauth/tokeninfo",
          headers: bearer_headers(access_token)
        )
      end

      def me(access_token:)
        get(
          "https://api.clever.com/v3.0/me",
          headers: bearer_headers(access_token)
        )
      end
    end
  end
end
