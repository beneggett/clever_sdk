require "test_helper"

class CleverSDK::Api::UsersTest < CleverSDK::Test
  def test_users
    VCR.use_cassette("users") do
      response = CleverSDK::Api.new.users(access_token: "TEST_TOKEN")

      assert_equal 200, response.code
      assert_equal "application/json; charset=utf-8", response.headers["content-type"]

      body = response.body
      assert body
      data = body.dig("data")
      assert data
      assert_equal 100, data.count
    end
  end

  def test_users_with_limit
    VCR.use_cassette("users_with_limit") do
      response = CleverSDK::Api.new.users(access_token: "TEST_TOKEN", limit: 25)

      assert_equal 200, response.code
      assert_equal "application/json; charset=utf-8", response.headers["content-type"]

      body = response.body
      assert body
      data = body.dig("data")
      assert data
      assert_equal 25, data.count
    end
  end

  def test_users_with_starting_after
    VCR.use_cassette("users_with_starting_after") do
      response = CleverSDK::Api.new.users(access_token: "TEST_TOKEN", starting_after: "58da8c63d7dc0ca068000478")

      assert_equal 200, response.code
      assert_equal "application/json; charset=utf-8", response.headers["content-type"]

      body = response.body
      assert body
      data = body.dig("data")
      assert data
      assert_equal 100, data.count
    end
  end
end
