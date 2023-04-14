require "test_helper"

class CleverSDK::Client::SectionResourcesTest < CleverSDK::Test
  def test_section_resources
    VCR.use_cassette("section_resources") do
      resources = CleverSDK.client("TEST_TOKEN").section_resources("58da8c6a894273be68000182")

      assert_kind_of CleverSDK::Data::Resources, resources
      assert_equal 0, resources.count
      refute resources.next?
    end
  end
end
