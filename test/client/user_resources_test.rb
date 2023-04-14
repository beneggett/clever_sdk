require "test_helper"

class CleverSDK::Client::UserResourcesTest < CleverSDK::Test
  def test_user_resources
    VCR.use_cassette("user_resources") do
      resources = CleverSDK.client("TEST_TOKEN").user_resources("58da8c63d7dc0ca068000478")

      assert_kind_of CleverSDK::Data::Resources, resources
      assert_equal 0, resources.count
      refute resources.next?
    end
  end
end
