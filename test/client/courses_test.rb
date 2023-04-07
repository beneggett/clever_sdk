require "test_helper"

class CleverApi::Client::CoursesTest < CleverApi::Test
  def test_courses
    VCR.use_cassette("courses") do
      courses = CleverApi.client("TEST_TOKEN").courses

      assert_kind_of CleverApi::Data::Courses, courses
      assert_equal 100, courses.count
      assert courses.next?

      course = courses.first

      assert_kind_of CleverApi::Data::Course, course
      assert_equal "5970d4dd35e9e69741000160", course.id
      assert_equal "58da8a43cc70ab00017a1a87", course.district
      assert_equal "Class 001, Homeroom", course.name
      assert_equal "1", course.number
    end
  end

  def test_courses_with_limit
    VCR.use_cassette("courses_with_limit") do
      courses = CleverApi.client("TEST_TOKEN").courses(limit: 25)

      assert_kind_of CleverApi::Data::Courses, courses
      assert_equal 25, courses.count
      assert courses.next?
    end
  end

  def test_courses_with_starting_after
    VCR.use_cassette("courses_with_starting_after") do
      courses = CleverApi.client("TEST_TOKEN").courses(starting_after: "5970d4dd35e9e697410001e7")

      assert_kind_of CleverApi::Data::Courses, courses
      assert_equal 100, courses.count
      assert courses.next?
    end
  end

  def test_courses_next
    VCR.use_cassette("courses_next") do
      courses = CleverApi.client("TEST_TOKEN").courses

      assert_kind_of CleverApi::Data::Courses, courses
      assert_equal 100, courses.count
      assert courses.next?

      course = courses.first

      assert_kind_of CleverApi::Data::Course, course
      assert_equal "5970d4dd35e9e69741000160", course.id
      assert_equal "58da8a43cc70ab00017a1a87", course.district
      assert_equal "Class 001, Homeroom", course.name
      assert_equal "1", course.number

      next_courses = courses.next
      assert_kind_of CleverApi::Data::Courses, next_courses
      assert_equal 100, next_courses.count
      assert next_courses.next?

      next_course = next_courses.first

      assert_kind_of CleverApi::Data::Course, next_course
      assert_equal "5970d4dd35e9e697410001e8", next_course.id
      assert_equal "58da8a43cc70ab00017a1a87", next_course.district
      assert_equal "Grade 4 Music, Class 403", next_course.name
      assert_equal "403", next_course.number
    end
  end
end
