require "test_helper"

class CleverSDK::Client::ResourcesTest < CleverSDK::Test
  def test_resources_app
    VCR.use_cassette("resources_app") do
      resources = CleverSDK.client("TEST_TOKEN").resources

      assert_kind_of CleverSDK::Data::Resources, resources
      assert_equal 0, resources.count
      refute resources.next?
    end
  end

  def test_resources_student
    VCR.use_cassette("resources_student") do
      error = assert_raises CleverSDK::Error do
        CleverSDK.client("ilc_DEMO_STUDENT_TOKEN").resources
      end

      assert_equal 404, error.response.code
      assert_equal "text/html; charset=utf-8", error.response.headers["content-type"]
    end
  end

  def test_resources_teacher
    VCR.use_cassette("resources_teacher") do
      error = assert_raises CleverSDK::Error do
        CleverSDK.client("ilc_DEMO_TEACHER_TOKEN").resources
      end

      assert_equal 404, error.response.code
      assert_equal "text/html; charset=utf-8", error.response.headers["content-type"]
    end
  end

  def test_resources_school_admin
    VCR.use_cassette("resources_school_admin") do
      error = assert_raises CleverSDK::Error do
        CleverSDK.client("ilc_DEMO_SCHOOL_ADMIN_TOKEN").resources
      end

      assert_equal 404, error.response.code
      assert_equal "text/html; charset=utf-8", error.response.headers["content-type"]
    end
  end

  def test_resources_district_admin
    VCR.use_cassette("resources_district_admin") do
      error = assert_raises CleverSDK::Error do
        CleverSDK.client("ilc_DEMO_DISTRICT_ADMIN_TOKEN").resources
      end

      assert_equal 404, error.response.code
      assert_equal "text/html; charset=utf-8", error.response.headers["content-type"]
    end
  end
end
