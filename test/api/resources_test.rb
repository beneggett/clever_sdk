require "test_helper"

class CleverApi::Api::ResourcesTest < CleverApi::Test
  def test_resources_app
    VCR.use_cassette("resources_app") do
      response = CleverApi::Api.new.resources(access_token: "TEST_TOKEN")

      assert_equal 200, response.code
      assert_equal(response.headers["content-type"], "application/json")
      resources = response.body.dig("resources")
      assert resources
      assert_equal 0, resources.count
    end
  end

  def test_resources_student
    VCR.use_cassette("resources_student") do
      error = assert_raises CleverApi::Error do
        CleverApi::Api.new.resources(access_token: "ilc_DEMO_STUDENT_TOKEN")
      end

      assert_equal 404, error.response.code
      assert_equal "text/html; charset=utf-8", error.response.headers["content-type"]
    end
  end

  def test_resources_teacher
    VCR.use_cassette("resources_teacher") do
      error = assert_raises CleverApi::Error do
        CleverApi::Api.new.resources(access_token: "ilc_DEMO_TEACHER_TOKEN")
      end

      assert_equal 404, error.response.code
      assert_equal "text/html; charset=utf-8", error.response.headers["content-type"]
    end
  end

  def test_resources_school_admin
    VCR.use_cassette("resources_school_admin") do
      error = assert_raises CleverApi::Error do
        CleverApi::Api.new.resources(access_token: "ilc_DEMO_SCHOOL_ADMIN_TOKEN")
      end

      assert_equal 404, error.response.code
      assert_equal "text/html; charset=utf-8", error.response.headers["content-type"]
    end
  end

  def test_resources_district_admin
    VCR.use_cassette("resources_district_admin") do
      error = assert_raises CleverApi::Error do
        CleverApi::Api.new.resources(access_token: "ilc_DEMO_DISTRICT_ADMIN_TOKEN")
      end

      assert_equal 404, error.response.code
      assert_equal "text/html; charset=utf-8", error.response.headers["content-type"]
    end
  end
end
