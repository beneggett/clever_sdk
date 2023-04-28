require "test_helper"

class CleverSDK::Client::SchoolsTest < CleverSDK::Test
  def test_schools
    VCR.use_cassette("client/schools") do
      schools = CleverSDK.client("TEST_TOKEN").schools

      assert_kind_of CleverSDK::Data::Schools, schools
      assert_equal 4, schools.count
      refute schools.next?

      school = schools.first

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

  def test_schools_with_limit
    VCR.use_cassette("client/schools_with_limit") do
      schools = CleverSDK.client("TEST_TOKEN").schools(limit: 3)

      assert_kind_of CleverSDK::Data::Schools, schools
      assert_equal 3, schools.count
      assert schools.next?
    end
  end

  def test_schools_with_starting_after
    VCR.use_cassette("client/schools_with_starting_after") do
      schools = CleverSDK.client("TEST_TOKEN").schools(starting_after: "58da8c58155b940248000007")

      assert_kind_of CleverSDK::Data::Schools, schools
      assert_equal 3, schools.count
      refute schools.next?
    end
  end

  def test_schools_next
    VCR.use_cassette("client/schools_next") do
      schools = CleverSDK.client("TEST_TOKEN").schools(limit: 3)

      assert_kind_of CleverSDK::Data::Schools, schools
      assert_equal 3, schools.count
      assert schools.next?

      school = schools.first

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

      next_schools = schools.next
      assert_kind_of CleverSDK::Data::Schools, next_schools
      assert_equal 1, next_schools.count
      refute next_schools.next?

      next_school = next_schools.first

      assert_kind_of CleverSDK::Data::School, next_school
      assert_equal "58da8c58155b94024800000a", next_school.id
      assert_equal "58da8a43cc70ab00017a1a87", next_school.district
      assert_equal "Rockaway Beach Middle School Campus 3", next_school.name
      assert_equal "2ZT381", next_school.school_number
      assert_equal "2ZT381", next_school.sis_id
      assert_equal "6", next_school.low_grade
      assert_equal "8", next_school.high_grade
      assert_equal "322 Old Beach 88th Street", next_school.location.dig("address")
      assert_equal "Rockaway Beach", next_school.location.dig("city")
      assert_equal "NY", next_school.location.dig("state")
      assert_equal "11693", next_school.location.dig("zip")
      assert_equal "(718) 555-8989", next_school.phone
      assert_equal "", next_school.ext.dig("charter_school")
      assert_equal "Leonard Springsteen", next_school.principal.dig("name")
      assert_equal "lspringsteen@mailinator.com", next_school.principal.dig("email")
      assert_kind_of DateTime, next_school.created
      assert_kind_of DateTime, next_school.last_modified
    end
  end
end
