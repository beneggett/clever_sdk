require "test_helper"

class CleverApi::Client::CourseSchoolsTest < CleverApi::Test
  def test_course_schools
    VCR.use_cassette("course_schools") do
      schools = CleverApi.client("TEST_TOKEN").course_schools("5970d4dd35e9e69741000160")

      assert_kind_of CleverApi::Data::Schools, schools
      assert_equal 1, schools.count
      refute schools.next?

      school = schools.first

      assert_kind_of CleverApi::Data::School, school
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
end
