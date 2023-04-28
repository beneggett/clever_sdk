require "test_helper"

class CleverSDK::Client::CourseRefsTest < CleverSDK::Test
  def test_course_district
    VCR.use_cassette("client/course_refs_district") do
      course = CleverSDK.client("TEST_TOKEN").course("5970d4dd35e9e69741000160")
      district = course.refs.district

      assert_kind_of CleverSDK::Data::District, district
      assert_equal "58da8a43cc70ab00017a1a87", district.id
      assert_equal "#DEMO Certification ISD - Events", district.name
    end
  end

  def test_course_resources
    VCR.use_cassette("client/course_refs_resources") do
      course = CleverSDK.client("TEST_TOKEN").course("5970d4dd35e9e69741000160")
      resources = course.refs.resources

      assert_kind_of CleverSDK::Data::Resources, resources
      assert_equal 0, resources.count
    end
  end

  def test_course_schools
    VCR.use_cassette("client/course_refs_schools") do
      course = CleverSDK.client("TEST_TOKEN").course("5970d4dd35e9e69741000160")
      schools = course.refs.schools

      assert_kind_of CleverSDK::Data::Schools, schools
      assert_equal 1, schools.count
      refute schools.next?

      assert_kind_of CleverSDK::Data::School, schools.to_a.first
      assert_equal "58da8c58155b940248000007", schools.to_a.first.id
    end
  end

  def test_course_sections
    VCR.use_cassette("client/course_refs_sections") do
      course = CleverSDK.client("TEST_TOKEN").course("5970d4dd35e9e69741000160")
      sections = course.refs.sections

      assert_kind_of CleverSDK::Data::Sections, sections
      assert_equal 1, sections.count
      refute sections.next?

      assert_kind_of CleverSDK::Data::Section, sections.to_a.first
      assert_equal "58da8c6b894273be680001fa", sections.to_a.first.id
    end
  end
end
