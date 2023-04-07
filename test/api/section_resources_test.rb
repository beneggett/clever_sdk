require "test_helper"

class CleverApi::Api::SectionResourcesTest < CleverApi::Test
  def test_section_resources
    VCR.use_cassette("section_resources") do
      response = CleverApi::Api.new.section_resources(access_token: "TEST_TOKEN", id: "58da8c6a894273be68000182")

      assert_equal 200, response.code
      assert_equal(response.headers["content-type"], "application/json")
      resources = response.body.dig("resources")
      assert resources
      assert_equal 0, resources.count
    end
  end
end
