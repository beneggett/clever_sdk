require "test_helper"

class CleverSDK::Client::CourseTest < CleverSDK::Test
  def test_courses
    VCR.use_cassette("course") do
      course = CleverSDK.client("TEST_TOKEN").course("5970d4dd35e9e69741000160")

      assert_kind_of CleverSDK::Data::Course, course
      assert_equal "5970d4dd35e9e69741000160", course.id
      assert_equal "58da8a43cc70ab00017a1a87", course.district
      assert_equal "Class 001, Homeroom", course.name
      assert_equal "1", course.number
    end
  end
end
