require "test_helper"

class CleverApi::Client::UserResourcesTest < CleverApi::Test
  def test_user_resources
    VCR.use_cassette("user_resources") do
      resources = CleverApi.client("TEST_TOKEN").user_resources("58da8c63d7dc0ca068000478")

      assert_kind_of CleverApi::Data::Resources, resources
      assert_equal 0, resources.count
      refute resources.next?
    end
  end
end
