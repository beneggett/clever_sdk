require "test_helper"

class CleverSDK::Client::SchoolDistrictTest < CleverSDK::Test
  def test_school_district
    VCR.use_cassette("school_district") do
      district = CleverSDK.client("TEST_TOKEN").school_district("58da8c58155b940248000007")

      assert_kind_of CleverSDK::Data::District, district
      assert_equal "58da8a43cc70ab00017a1a87", district.id
      assert_equal "#DEMO Certification ISD - Events", district.name
      assert_equal "running", district.state
      assert_nil district.mdr_number
      assert_nil district.nces_id
      assert_equal "sftp", district.sis_type
      assert_kind_of DateTime, district.last_sync
      assert_equal "https://clever.com/in/demo-certification3cc70ab00017a1a87", district.portal_url
      assert_equal ["Clever Passwords"], district.login_methods
      assert_kind_of Date, district.launch_date
      assert_nil district.pause_start
      assert_nil district.pause_end
      assert_kind_of CleverSDK::Data::District::Contact, district.district_contact
      assert_equal "58da8a43ca1f1e0001aa4220", district.district_contact.id
      assert_equal "Amelie", district.district_contact.first_name
      assert_equal "Zeng", district.district_contact.last_name
      assert_equal "amelie.zeng+certification@clever.com", district.district_contact.email
      assert_equal "", district.district_contact.title
      assert_equal "", district.error
    end
  end
end
