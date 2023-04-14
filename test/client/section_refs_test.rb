require "test_helper"

class CleverSDK::Client::SectionRefsTest < CleverSDK::Test
  def test_section_course
    VCR.use_cassette("client/section_refs_course") do
      section = CleverSDK.client("TEST_TOKEN").section("58da8c6a894273be68000182")
      course = section.refs.course

      assert_kind_of CleverSDK::Data::Course, course
      assert_equal "5970d4de35e9e69741000277", course.id
      assert_equal "Sixth Grade Advisory", course.name
    end
  end

  def test_section_district
    VCR.use_cassette("client/section_refs_district") do
      section = CleverSDK.client("TEST_TOKEN").section("58da8c6a894273be68000182")
      district = section.refs.district

      assert_kind_of CleverSDK::Data::District, district
      assert_equal "58da8a43cc70ab00017a1a87", district.id
      assert_equal "#DEMO Certification ISD - Events", district.name
    end
  end

  def test_section_resources
    VCR.use_cassette("client/section_refs_resources") do
      section = CleverSDK.client("TEST_TOKEN").section("58da8c6a894273be68000182")
      resources = section.refs.resources

      assert_kind_of CleverSDK::Data::Resources, resources
      assert_equal 0, resources.count
      refute resources.next?
    end
  end

  def test_section_school
    VCR.use_cassette("client/section_refs_school") do
      section = CleverSDK.client("TEST_TOKEN").section("58da8c6a894273be68000182")
      school = section.refs.school

      assert_kind_of CleverSDK::Data::School, school
      assert_equal "58da8a43cc70ab00017a1a87", school.id
      assert_equal "#DEMO Certification ISD - Events", school.name
    end
  end

  def test_section_term
    VCR.use_cassette("client/section_refs_term") do
      section = CleverSDK.client("TEST_TOKEN").section("58da8c6a894273be68000182")
      term = section.refs.term

      assert_kind_of CleverSDK::Data::Term, term
      assert_equal "58da8a43cc70ab00017a1a87", term.id
      assert_equal "#DEMO Certification ISD - Events", term.name
    end
  end

  def test_section_users
    VCR.use_cassette("client/section_refs_users") do
      section = CleverSDK.client("TEST_TOKEN").section("58da8c6a894273be68000182")
      users = section.refs.users

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
