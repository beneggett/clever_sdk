require "test_helper"

class CleverSDK::Client::EventTest < CleverSDK::Test
  def test_events
    VCR.use_cassette("event") do
      event = CleverSDK.client("TEST_TOKEN").event("640df94fd306111b2385ee9d")

      assert_kind_of CleverSDK::Data::Event, event
      assert_equal "640df94fd306111b2385ee9d", event.id
      assert_equal "districts.updated", event.type
      assert_kind_of DateTime, event.created
      assert_kind_of CleverSDK::Data::District, event.object
      assert_equal "2023-03-09T22:46:43.807Z", event.previous_attributes.dig("last_sync")

      district = event.object
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
