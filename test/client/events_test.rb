require "test_helper"

class CleverSDK::Client::EventsTest < CleverSDK::Test
  def test_events
    VCR.use_cassette("events") do
      events = CleverSDK.client("TEST_TOKEN").events

      assert_kind_of CleverSDK::Data::Events, events
      assert_equal 100, events.count
      assert events.next?

      event = events.first
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

  def test_events_with_limit
    VCR.use_cassette("events_with_limit") do
      events = CleverSDK.client("TEST_TOKEN").events(limit: 25)

      assert_kind_of CleverSDK::Data::Events, events
      assert_equal 25, events.count
      assert events.next?
    end
  end

  def test_events_with_starting_after
    VCR.use_cassette("events_with_starting_after") do
      events = CleverSDK.client("TEST_TOKEN").events(starting_after: "640df950d306111b2385f72b")

      assert_kind_of CleverSDK::Data::Events, events
      assert_equal 100, events.count
      assert events.next?

      event = events.first

      assert_kind_of CleverSDK::Data::Event, event
      assert_equal "640df950d306111b2385f72c", event.id
      assert_equal "users.updated", event.type
      assert_kind_of DateTime, event.created
      assert_kind_of CleverSDK::Data::User, event.object
      assert_equal "", event.previous_attributes.dig("roles", "student", "ext", "gifted_status")
      assert_equal "X", event.previous_attributes.dig("roles", "student", "gender")
    end
  end

  def test_events_next
    VCR.use_cassette("events_next") do
      events = CleverSDK.client("TEST_TOKEN").events

      assert_kind_of CleverSDK::Data::Events, events
      assert_equal 100, events.count
      assert events.next?

      event = events.first

      assert_kind_of CleverSDK::Data::Event, event
      assert_equal "640df94fd306111b2385ee9d", event.id
      assert_equal "districts.updated", event.type
      assert_kind_of DateTime, event.created
      assert_kind_of CleverSDK::Data::District, event.object
      assert_equal "2023-03-09T22:46:43.807Z", event.previous_attributes.dig("last_sync")

      next_events = events.next
      assert_kind_of CleverSDK::Data::Events, next_events
      assert_equal 100, next_events.count
      assert next_events.next?

      next_event = next_events.first

      assert_kind_of CleverSDK::Data::Event, next_event
      assert_equal "640df950d306111b2385f72c", next_event.id
      assert_equal "users.updated", next_event.type
      assert_kind_of DateTime, next_event.created
      assert_kind_of CleverSDK::Data::User, next_event.object
      assert_equal "", next_event.previous_attributes.dig("roles", "student", "ext", "gifted_status")
      assert_equal "X", next_event.previous_attributes.dig("roles", "student", "gender")
    end
  end
end
