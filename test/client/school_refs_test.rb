require "test_helper"

class CleverSDK::Client::SchoolRefsTest < CleverSDK::Test
  def test_school_courses
    VCR.use_cassette("client/school_refs_courses") do
      school = CleverSDK.client("TEST_TOKEN").school("58da8c58155b940248000007")
      courses = school.refs.courses

      assert_kind_of CleverSDK::Data::Courses, courses
      assert_equal 100, courses.count
      assert courses.next?

      assert_kind_of CleverSDK::Data::Course, courses.to_a.first
      assert_equal "5970d4dd35e9e69741000160", courses.to_a.first.id
      assert_kind_of CleverSDK::Data::Course, courses.to_a.last
      assert_equal "5970d4dd35e9e697410001ff", courses.to_a.last.id
    end
  end

  def test_school_district
    VCR.use_cassette("client/school_refs_district") do
      school = CleverSDK.client("TEST_TOKEN").school("58da8c58155b940248000007")
      district = school.refs.district

      assert_kind_of CleverSDK::Data::District, district
      assert_equal "58da8a43cc70ab00017a1a87", district.id
      assert_equal "#DEMO Certification ISD - Events", district.name
    end
  end

  def test_school_sections
    VCR.use_cassette("client/school_refs_sections") do
      school = CleverSDK.client("TEST_TOKEN").school("58da8c58155b940248000007")
      sections = school.refs.sections

      assert_kind_of CleverSDK::Data::Sections, sections
      assert_equal 100, sections.count
      assert sections.next?

      assert_kind_of CleverSDK::Data::Section, sections.to_a.first
      assert_equal "58da8c6a894273be6800018b", sections.to_a.first.id
      assert_kind_of CleverSDK::Data::Section, sections.to_a.last
      assert_equal "58da8c6b894273be680002b1", sections.to_a.last.id
    end
  end

  def test_school_terms
    VCR.use_cassette("client/school_refs_terms") do
      school = CleverSDK.client("TEST_TOKEN").school("58da8c58155b940248000007")
      terms = school.refs.terms

      assert_kind_of CleverSDK::Data::Terms, terms
      assert_equal 4, terms.count
      refute terms.next?

      assert_kind_of CleverSDK::Data::Term, terms.to_a.first
      assert_equal "5b42365868c8d6104f634d33", terms.to_a.first.id
      assert_kind_of CleverSDK::Data::Term, terms.to_a.last
      assert_equal "5b42365868c8d6104f634d36", terms.to_a.last.id
    end
  end

  def test_school_users
    VCR.use_cassette("client/school_refs_users") do
      school = CleverSDK.client("TEST_TOKEN").school("58da8c58155b940248000007")
      users = school.refs.users

      assert_kind_of CleverSDK::Data::Users, users
      assert_equal 100, users.count
      assert users.next?

      assert_kind_of CleverSDK::Data::User, users.to_a.first
      assert_equal "58da8c63d7dc0ca0680003ed", users.to_a.first.id
      assert_kind_of CleverSDK::Data::User, users.to_a.last
      assert_equal "58da8c63d7dc0ca06800048d", users.to_a.last.id
    end
  end
end
