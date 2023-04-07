require "test_helper"

class CleverApi::Api::UserResourcesTest < CleverApi::Test
  def test_user_resources
    VCR.use_cassette("user_resources") do
      response = CleverApi::Api.new.user_resources(access_token: "TEST_TOKEN", id: "58da8c63d7dc0ca068000478")

      assert_equal 200, response.code
      assert_equal(response.headers["content-type"], "application/json")
      resources = response.body.dig("resources")
      assert resources
      assert_equal 0, resources.count
    end
  end
end
