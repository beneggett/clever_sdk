require "test_helper"

class CleverSDK::Client::SchoolCoursesTest < CleverSDK::Test
  def test_school_courses
    VCR.use_cassette("client/school_courses") do
      courses = CleverSDK.client("TEST_TOKEN").school_courses("58da8c58155b940248000007")

      assert_kind_of CleverSDK::Data::Courses, courses
      assert_equal 100, courses.count
      assert courses.next?

      course = courses.first

      assert_kind_of CleverSDK::Data::Course, course
      assert_equal "5970d4dd35e9e69741000160", course.id
      assert_equal "58da8a43cc70ab00017a1a87", course.district
      assert_equal "Class 001, Homeroom", course.name
      assert_equal "1", course.number
    end
  end

  def test_courses_with_limit
    VCR.use_cassette("client/school_courses_with_limit") do
      courses = CleverSDK.client("TEST_TOKEN").school_courses("58da8c58155b940248000007", limit: 25)

      assert_kind_of CleverSDK::Data::Courses, courses
      assert_equal 25, courses.count
      assert courses.next?
    end
  end

  def test_courses_with_starting_after
    VCR.use_cassette("client/school_courses_with_starting_after") do
      courses = CleverSDK.client("TEST_TOKEN").school_courses("58da8c58155b940248000007", starting_after: "5970d4dd35e9e697410001ff")

      assert_kind_of CleverSDK::Data::Courses, courses
      assert_equal 27, courses.count
      refute courses.next?

      course = courses.first

      assert_kind_of CleverSDK::Data::Course, course
      assert_equal "5970d4dd35e9e69741000200", course.id
      assert_equal "58da8a43cc70ab00017a1a87", course.district
      assert_equal "Grade 5 Social Studies, Class 503", course.name
      assert_equal "503", course.number
    end
  end

  def test_courses_next
    VCR.use_cassette("client/schoool_courses_next") do
      courses = CleverSDK.client("TEST_TOKEN").school_courses("58da8c58155b940248000007")

      assert_kind_of CleverSDK::Data::Courses, courses
      assert_equal 100, courses.count
      assert courses.next?

      course = courses.first

      assert_kind_of CleverSDK::Data::Course, course
      assert_equal "5970d4dd35e9e69741000160", course.id
      assert_equal "58da8a43cc70ab00017a1a87", course.district
      assert_equal "Class 001, Homeroom", course.name
      assert_equal "1", course.number

      next_courses = courses.next
      assert_kind_of CleverSDK::Data::Courses, next_courses
      assert_equal 27, next_courses.count
      refute next_courses.next?

      next_course = next_courses.first

      assert_kind_of CleverSDK::Data::Course, next_course
      assert_equal "5970d4dd35e9e69741000200", next_course.id
      assert_equal "58da8a43cc70ab00017a1a87", next_course.district
      assert_equal "Grade 5 Social Studies, Class 503", next_course.name
      assert_equal "503", next_course.number
    end
  end
end
