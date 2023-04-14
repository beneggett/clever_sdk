require "test_helper"

class CleverSDK::Api::CourseTest < CleverSDK::Test
  def test_courses
    VCR.use_cassette("api/course") do
      course = CleverSDK.client("TEST_TOKEN").course("5970d4dd35e9e69741000160")

      assert_kind_of CleverSDK::Data::Course, course
      assert_equal "5970d4dd35e9e69741000160", course.id
      assert_equal "58da8a43cc70ab00017a1a87", course.district
      assert_equal "Class 001, Homeroom", course.name
      assert_equal "1", course.number
    end
  end

  def test_course_district
    VCR.use_cassette("api/course_district") do
      response = CleverSDK::Api.new.course_district(access_token: "TEST_TOKEN", id: "5970d4dd35e9e69741000160")

      assert_equal 200, response.code
      assert_equal("application/json; charset=utf-8", response.headers["content-type"])
      district = response.body.dig("data")

      assert_equal "58da8a43cc70ab00017a1a87", district.dig("id")
      assert_equal "#DEMO Certification ISD - Events", district.dig("name")
      assert_equal "running", district.dig("state")
      assert_nil district.dig("mdr_number")
      assert_nil district.dig("nces_id")
      assert_equal "sftp", district.dig("sis_type")
      assert district.dig("last_sync")
      assert_equal "https://clever.com/in/demo-certification3cc70ab00017a1a87", district.dig("portal_url")
      assert_equal ["Clever Badges", "Clever Passwords"], district.dig("login_methods")
      assert_equal "2017-07-31", district.dig("launch_date")
      assert_nil district.dig("pause_start")
      assert_nil district.dig("pause_end")
      assert_equal "58da8a43ca1f1e0001aa4220", district.dig("district_contact", "id")
      assert_equal "Amelie", district.dig("district_contact", "name", "first")
      assert_equal "Zeng", district.dig("district_contact", "name", "last")
      assert_equal "amelie.zeng+certification@clever.com", district.dig("district_contact", "email")
      assert_equal "", district.dig("district_contact", "title")
      assert_equal "", district.dig("error")
    end
  end

  def test_course_resources
    VCR.use_cassette("api/course_resources") do
      response = CleverSDK::Api.new.course_resources(access_token: "TEST_TOKEN", id: "5970d4dd35e9e69741000160")

      assert_equal 200, response.code
      assert_equal("application/json", response.headers["content-type"])
      resources = response.body.dig("resources")
      assert resources
      assert_equal 0, resources.count
    end
  end

  def test_course_schools
    VCR.use_cassette("api/course_schools") do
      response = CleverSDK::Api.new.course_schools(access_token: "TEST_TOKEN", id: "5970d4dd35e9e69741000160")

      assert_equal 200, response.code
      assert_equal("application/json; charset=utf-8", response.headers["content-type"])
      data = response.body.dig("data")
      assert data
      assert_equal 1, data.count

      school = data.first.dig("data")

      assert_equal "58da8c58155b940248000007", school.dig("id")
      assert_equal "58da8a43cc70ab00017a1a87", school.dig("district")
      assert_equal "Pineapple Elementary School", school.dig("name")
      assert_equal "13K123", school.dig("school_number")
      assert_equal "13K123", school.dig("sis_id")
      assert_equal "TransitionalKindergarten", school.dig("low_grade")
      assert_equal "5", school.dig("high_grade")
      assert_equal "110 Pineapple Street", school.dig("location", "address")
      assert_equal "Brooklyn", school.dig("location", "city")
      assert_equal "NY", school.dig("location", "state")
      assert_equal "11201", school.dig("location", "zip")
      assert_equal "(718) 555-4567", school.dig("phone")
      assert_equal "N", school.dig("ext", "charter_school")
      assert_equal "Cecilia Roderick", school.dig("principal", "name")
      assert_equal "ceciliar@mailinator.com", school.dig("principal", "email")
      assert school.dig("created")
      assert school.dig("last_modified")
    end
  end

  def test_course_sections
    VCR.use_cassette("api/course_sections") do
      response = CleverSDK::Api.new.course_sections(access_token: "TEST_TOKEN", id: "5970d4dd35e9e69741000160")

      assert_equal 200, response.code
      assert_equal("application/json; charset=utf-8", response.headers["content-type"])
      data = response.body.dig("data")
      assert data
      assert_equal 1, data.count

      section = data.first.dig("data")

      assert_equal "58da8c6b894273be680001fa", section.dig("id")
      assert_equal "58da8a43cc70ab00017a1a87", section.dig("district")
      assert_equal "5970d4dd35e9e69741000160", section.dig("course")
      assert_equal "58da8c58155b940248000007", section.dig("school")
      assert_equal "5b42365868c8d6104f634d34", section.dig("term_id")
      assert_equal "Class 001, Homeroom - Willms - 0", section.dig("name")
      assert_equal "homeroom/advisory", section.dig("subject")
      assert_equal "", section.dig("section_number")
      assert_equal "708", section.dig("sis_id")
      assert_equal "Kindergarten", section.dig("grade")
      assert_equal "0", section.dig("period")
      assert_equal "A1", section.dig("ext", "classroom")
      assert_equal 20, section.dig("students").count
      assert_equal "5faac8b7bc447500a10ae87e", section.dig("teacher")
      assert_equal 1, section.dig("teachers").count
      assert section.dig("created")
      assert section.dig("last_modified")
    end
  end
end
