require "test_helper"

class CleverSDK::Api::AuthenticationTest < CleverSDK::Test
  def test_tokens
    VCR.use_cassette("api/tokens") do
      response = CleverSDK::Api.new.tokens(client_id: "095b82cbbd8c68714d1c", client_secret: "4b338489ceb4bec362461a7c96e3aa609efff049")

      assert_equal 200, response.code
      assert_equal("application/json; charset=utf-8", response.headers["content-type"])
      tokens = response.body.dig("data")
      assert_equal 3, tokens.count
    end
  end

  def test_tokens_with_district
    VCR.use_cassette("api/token") do
      response = CleverSDK::Api.new.tokens(client_id: "095b82cbbd8c68714d1c", client_secret: "4b338489ceb4bec362461a7c96e3aa609efff049", district: "58da8a43cc70ab00017a1a87")

      assert_equal 200, response.code
      assert_equal("application/json; charset=utf-8", response.headers["content-type"])
      tokens = response.body.dig("data")
      assert_equal 1, tokens.count
    end
  end

  def test_tokeninfo
    VCR.use_cassette("api/tokeninfo") do
      response = CleverSDK::Api.new.tokeninfo(access_token: "ilc_DEMO_TEACHER_TOKEN")

      assert_equal 200, response.code
      assert_equal("application/json; charset=utf-8", response.headers["content-type"])
      assert_equal "4c63c1cf623dce82caac", response.body.dig("client_id")
      assert_equal 10, response.body.dig("scopes").count
    end
  end

  def test_me
    VCR.use_cassette("api/me") do
      response = CleverSDK::Api.new.me(access_token: "ilc_DEMO_TEACHER_TOKEN")

      assert_equal 200, response.code
      assert_equal("application/json; charset=utf-8", response.headers["content-type"])
      data = response.body.dig("data")
      assert data
      assert_equal "58da8c5da7a7e5a647000094", data.dig("id")
      assert_equal "58da8a43cc70ab00017a1a87", data.dig("district")
      assert_equal "teacher", data.dig("type")
    end
  end
end
