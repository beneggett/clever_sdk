require "test_helper"

class CleverApi::Client::SectionResourcesTest < CleverApi::Test
  def test_section_resources
    VCR.use_cassette("section_resources") do
      resources = CleverApi.client("TEST_TOKEN").section_resources("58da8c6a894273be68000182")

      assert_kind_of CleverApi::Data::Resources, resources
      assert_equal 0, resources.count
      refute resources.next?
    end
  end
end
