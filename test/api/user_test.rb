require "test_helper"

class CleverSDK::Api::UserTest < CleverSDK::Test
  def test_user
    VCR.use_cassette("user") do
      response = CleverSDK::Api.new.user(access_token: "TEST_TOKEN", id: "58da8c63d7dc0ca068000478")

      assert_equal 200, response.code
      assert_equal "application/json; charset=utf-8", response.headers["content-type"]

      body = response.body
      assert body
      data = body.dig("data")
      assert data
      assert_equal "58da8c63d7dc0ca068000478", data.dig("id")
      assert_equal "58da8a43cc70ab00017a1a87", data.dig("district")
      assert_equal "james.s@example.com", data.dig("email")
      assert_equal "James", data.dig("name", "first")
      assert_equal "Spencer", data.dig("name", "last")
    end
  end
end
