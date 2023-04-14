require "test_helper"

class CleverSDK::Client::UserRefsTest < CleverSDK::Test
  def test_user_district
    VCR.use_cassette("client/user_refs_district") do
      user = CleverSDK.client("TEST_TOKEN").user("58da8c63d7dc0ca068000478")
      district = user.refs.district

      assert_kind_of CleverSDK::Data::District, district
      assert_equal "58da8a43cc70ab00017a1a87", district.id
      assert_equal "#DEMO Certification ISD - Events", district.name
    end
  end

  def test_user_schools
    VCR.use_cassette("client/user_refs_schools") do
      user = CleverSDK.client("TEST_TOKEN").user("58da8c63d7dc0ca068000478")
      schools = user.refs.schools

      assert_kind_of CleverSDK::Data::Schools, schools
      assert_equal 2, schools.count
      refute schools.next?

      assert_kind_of CleverSDK::Data::School, schools.to_a.first
      assert_equal "58da8c58155b940248000007", schools.to_a.first.id
      assert_kind_of CleverSDK::Data::School, schools.to_a.last
      assert_equal "58da8c58155b940248000008", schools.to_a.last.id
    end
  end

  def test_user_sections
    VCR.use_cassette("client/user_refs_sections") do
      user = CleverSDK.client("TEST_TOKEN").user("58da8c63d7dc0ca068000478")
      sections = user.refs.sections

      assert_kind_of CleverSDK::Data::Sections, sections
      assert_equal 3, sections.count
      refute sections.next?

      assert_kind_of CleverSDK::Data::Section, sections.to_a.first
      assert_equal "58da8c6a894273be6800018b", sections.to_a.first.id
      assert_kind_of CleverSDK::Data::Section, sections.to_a.last
      assert_equal "58da8c6b894273be680002eb", sections.to_a.last.id
    end
  end

  def test_user_mycontacts
    VCR.use_cassette("client/user_refs_mycontacts") do
      user = CleverSDK.client("TEST_TOKEN").user("58da8c63d7dc0ca0680003ed")
      assert user.student?
      mycontacts = user.refs.mycontacts

      assert_kind_of CleverSDK::Data::Users, mycontacts
      assert_equal 1, mycontacts.count
      refute mycontacts.next?

      assert_kind_of CleverSDK::Data::User, mycontacts.to_a.first
      assert_equal "5faac8b9bc447500a10aebe8", mycontacts.to_a.first.id
    end
  end

  def test_user_mystudents
    VCR.use_cassette("client/user_refs_mystudents") do
      user = CleverSDK.client("TEST_TOKEN").user("5faac8b7bc447500a10ae840")
      assert user.teacher?
      mystudents = user.refs.mystudents

      assert_kind_of CleverSDK::Data::Users, mystudents
      assert_equal 25, mystudents.count
      refute mystudents.next?

      assert_kind_of CleverSDK::Data::User, mystudents.to_a.first
      assert_equal "58da8c63d7dc0ca0680003ee", mystudents.to_a.first.id
      assert_kind_of CleverSDK::Data::User, mystudents.to_a.last
      assert_equal "58da8c65d7dc0ca0680007cd", mystudents.to_a.last.id
    end
  end

  def test_user_myteachers
    VCR.use_cassette("client/user_refs_myteachers") do
      user = CleverSDK.client("TEST_TOKEN").user("58da8c63d7dc0ca0680003ed")
      assert user.student?
      myteachers = user.refs.myteachers

      assert_kind_of CleverSDK::Data::Users, myteachers
      assert_equal 1, myteachers.count
      refute myteachers.next?

      assert_kind_of CleverSDK::Data::User, myteachers.to_a.first
      assert_equal "5faac8b7bc447500a10ae87f", myteachers.to_a.first.id
    end
  end
end
