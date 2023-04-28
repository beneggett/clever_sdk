require "test_helper"

class CleverSDK::Client::SectionTest < CleverSDK::Test
  def test_sections
    VCR.use_cassette("client/section") do
      section = CleverSDK.client("TEST_TOKEN").section("58da8c6a894273be68000182")

      assert_kind_of CleverSDK::Data::Section, section
      assert_equal "58da8c6a894273be68000182", section.id
      assert_equal "58da8a43cc70ab00017a1a87", section.district
      assert_equal "5970d4de35e9e69741000277", section.course
      assert_equal "58da8c58155b940248000008", section.school
      assert_equal "5b42365868c8d6104f634d34", section.term_id
      assert_equal "Sixth Grade Advisory - Madison - 4", section.name
      assert_equal "homeroom/advisory", section.subject
      assert_equal "", section.section_number
      assert_equal "587", section.sis_id
      assert_equal "6", section.grade
      assert_equal "4", section.period
      assert_equal "A1", section.ext.dig("classroom")
      assert_equal 26, section.students.count
      assert_equal "5faac8b7bc447500a10ae88f", section.teacher
      assert_equal 1, section.teachers.count
      assert_kind_of DateTime, section.created
      assert_kind_of DateTime, section.last_modified
    end
  end

  def test_section_course
    VCR.use_cassette("client/section_course") do
      course = CleverSDK.client("TEST_TOKEN").section_course("58da8c6a894273be68000182")

      assert_kind_of CleverSDK::Data::Course, course
      assert_equal "5970d4de35e9e69741000277", course.id
      assert_equal "Sixth Grade Advisory", course.name
    end
  end

  def test_section_district
    VCR.use_cassette("client/section_district") do
      district = CleverSDK.client("TEST_TOKEN").section_district("58da8c6a894273be68000182")

      assert_kind_of CleverSDK::Data::District, district
      assert_equal "58da8a43cc70ab00017a1a87", district.id
      assert_equal "#DEMO Certification ISD - Events", district.name
    end
  end

  def test_section_resources
    VCR.use_cassette("client/section_resources") do
      resources = CleverSDK.client("TEST_TOKEN").section_resources("58da8c6a894273be68000182")

      assert_kind_of CleverSDK::Data::Resources, resources
      assert_equal 0, resources.count
      refute resources.next?
    end
  end

  def test_section_school
    VCR.use_cassette("client/section_school") do
      school = CleverSDK.client("TEST_TOKEN").section_school("58da8c6a894273be68000182")

      assert_kind_of CleverSDK::Data::School, school
      assert_equal "58da8a43cc70ab00017a1a87", school.id
      assert_equal "#DEMO Certification ISD - Events", school.name
    end
  end

  def test_section_term
    VCR.use_cassette("client/section_term") do
      term = CleverSDK.client("TEST_TOKEN").section_term("58da8c6a894273be68000182")

      assert_kind_of CleverSDK::Data::Term, term
      assert_equal "58da8a43cc70ab00017a1a87", term.id
      assert_equal "#DEMO Certification ISD - Events", term.name
    end
  end

  def test_section_users
    VCR.use_cassette("client/section_users") do
      users = CleverSDK.client("TEST_TOKEN").section_users("58da8c6a894273be68000182")

      assert_kind_of CleverSDK::Data::Users, users
      assert_equal 27, users.count
      refute users.next?

      assert_kind_of CleverSDK::Data::User, users.to_a.first
      assert_equal "58da8c63d7dc0ca06800040a", users.to_a.first.id
      assert_kind_of CleverSDK::Data::User, users.to_a.last
      assert_equal "5faac8b7bc447500a10ae88f", users.to_a.last.id
    end
  end
end
