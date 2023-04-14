require "test_helper"

class CleverSDK::Client::CourseTest < CleverSDK::Test
  def test_courses
    VCR.use_cassette("client/course") do
      course = CleverSDK.client("TEST_TOKEN").course("5970d4dd35e9e69741000160")

      assert_kind_of CleverSDK::Data::Course, course
      assert_equal "5970d4dd35e9e69741000160", course.id
      assert_equal "58da8a43cc70ab00017a1a87", course.district
      assert_equal "Class 001, Homeroom", course.name
      assert_equal "1", course.number
    end
  end

  def test_course_district
    VCR.use_cassette("client/course_district") do
      district = CleverSDK.client("TEST_TOKEN").course_district("5970d4dd35e9e69741000160")

      assert_kind_of CleverSDK::Data::District, district
      assert_equal "58da8a43cc70ab00017a1a87", district.id
      assert_equal "#DEMO Certification ISD - Events", district.name
    end
  end

  def test_course_resources
    VCR.use_cassette("client/course_resources") do
      resources = CleverSDK.client("TEST_TOKEN").course_resources("5970d4dd35e9e69741000160")

      assert_kind_of CleverSDK::Data::Resources, resources
      assert_equal 0, resources.count
    end
  end

  def test_course_schools
    VCR.use_cassette("client/course_schools") do
      schools = CleverSDK.client("TEST_TOKEN").course_schools("5970d4dd35e9e69741000160")

      assert_kind_of CleverSDK::Data::Schools, schools
      assert_equal 1, schools.count
      refute schools.next?

      assert_kind_of CleverSDK::Data::School, schools.to_a.first
      assert_equal "58da8c58155b940248000007", schools.to_a.first.id
    end
  end

  def test_course_sections
    VCR.use_cassette("client/course_sections") do
      sections = CleverSDK.client("TEST_TOKEN").course_sections("5970d4dd35e9e69741000160")

      assert_kind_of CleverSDK::Data::Sections, sections
      assert_equal 1, sections.count
      refute sections.next?

      assert_kind_of CleverSDK::Data::Section, sections.to_a.first
      assert_equal "58da8c6b894273be680001fa", sections.to_a.first.id
    end
  end
end
