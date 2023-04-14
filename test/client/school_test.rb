require "test_helper"

class CleverSDK::Client::SchoolTest < CleverSDK::Test
  def test_schools
    VCR.use_cassette("client/school") do
      school = CleverSDK.client("TEST_TOKEN").school("58da8c58155b940248000007")

      assert_kind_of CleverSDK::Data::School, school
      assert_equal "58da8c58155b940248000007", school.id
      assert_equal "58da8a43cc70ab00017a1a87", school.district
      assert_equal "Pineapple Elementary School", school.name
      assert_equal "13K123", school.school_number
      assert_equal "13K123", school.sis_id
      assert_equal "TransitionalKindergarten", school.low_grade
      assert_equal "5", school.high_grade
      assert_equal "110 Pineapple Street", school.location.dig("address")
      assert_equal "Brooklyn", school.location.dig("city")
      assert_equal "NY", school.location.dig("state")
      assert_equal "11201", school.location.dig("zip")
      assert_equal "(718) 555-4567", school.phone
      assert_equal "N", school.ext.dig("charter_school")
      assert_equal "Cecilia Roderick", school.principal.dig("name")
      assert_equal "ceciliar@mailinator.com", school.principal.dig("email")
      assert_kind_of DateTime, school.created
      assert_kind_of DateTime, school.last_modified
    end
  end

  def test_school_courses
    VCR.use_cassette("client/school_courses") do
      courses = CleverSDK.client("TEST_TOKEN").school_courses("58da8c58155b940248000007")

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
    VCR.use_cassette("client/school_district") do
      district = CleverSDK.client("TEST_TOKEN").school_district("58da8c58155b940248000007")

      assert_kind_of CleverSDK::Data::District, district
      assert_equal "58da8a43cc70ab00017a1a87", district.id
      assert_equal "#DEMO Certification ISD - Events", district.name
    end
  end

  def test_school_sections
    VCR.use_cassette("client/school_sections") do
      sections = CleverSDK.client("TEST_TOKEN").school_sections("58da8c58155b940248000007")

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
    VCR.use_cassette("client/school_terms") do
      terms = CleverSDK.client("TEST_TOKEN").school_terms("58da8c58155b940248000007")

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
    VCR.use_cassette("client/school_users") do
      users = CleverSDK.client("TEST_TOKEN").school_users("58da8c58155b940248000007")

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
