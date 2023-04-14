require "test_helper"

class CleverSDK::Api::UserResourcesTest < CleverSDK::Test
  def test_user_resources
    VCR.use_cassette("user_resources") do
      response = CleverSDK::Api.new.user_resources(access_token: "TEST_TOKEN", id: "58da8c63d7dc0ca068000478")

      assert_equal 200, response.code
      assert_equal(response.headers["content-type"], "application/json")
      resources = response.body.dig("resources")
      assert resources
      assert_equal 0, resources.count
    end
  end
end
