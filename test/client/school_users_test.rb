require "test_helper"

class CleverSDK::Client::SchoolUsersTest < CleverSDK::Test
  def test_school_users
    VCR.use_cassette("client/school_users") do
      users = CleverSDK.client("TEST_TOKEN").school_users("58da8c58155b940248000007")

      assert_kind_of CleverSDK::Data::Users, users
      assert_equal 100, users.count
      assert users.next?

      user = users.first

      assert_kind_of CleverSDK::Data::User, user
      assert_equal "58da8c63d7dc0ca0680003ed", user.id
      assert_equal "58da8a43cc70ab00017a1a87", user.district
      assert_equal "z.steve@example.net", user.email
      assert_equal "Steve", user.first_name
      assert_equal "Ziemann", user.last_name
      refute_empty user.roles
      assert_kind_of DateTime, user.created
      assert_kind_of DateTime, user.last_modified
    end
  end

  def test_users_with_limit
    VCR.use_cassette("client/school_users_with_limit") do
      users = CleverSDK.client("TEST_TOKEN").school_users("58da8c58155b940248000007", limit: 25)

      assert_kind_of CleverSDK::Data::Users, users
      assert_equal 25, users.count
      assert users.next?

      user = users.first

      assert_kind_of CleverSDK::Data::User, user
      assert_equal "58da8c63d7dc0ca0680003ed", user.id
      assert_equal "58da8a43cc70ab00017a1a87", user.district
      assert_equal "z.steve@example.net", user.email
      assert_equal "Steve", user.first_name
      assert_equal "Ziemann", user.last_name
      refute_empty user.roles
      assert_kind_of DateTime, user.created
      assert_kind_of DateTime, user.last_modified
    end
  end

  def test_users_with_starting_after
    VCR.use_cassette("client/school_users_with_starting_after") do
      users = CleverSDK.client("TEST_TOKEN").school_users("58da8c58155b940248000007", starting_after: "58da8c63d7dc0ca068000416")

      assert_kind_of CleverSDK::Data::Users, users
      assert_equal 100, users.count
      assert users.next?

      user = users.first

      assert_kind_of CleverSDK::Data::User, user
      assert_equal "58da8c63d7dc0ca068000417", user.id
      assert_equal "58da8a43cc70ab00017a1a87", user.district
      assert_equal "danny.g@example.com", user.email
      assert_equal "Danny", user.first_name
      assert_equal "Greenholt", user.last_name
      refute_empty user.roles
      assert_kind_of DateTime, user.created
      assert_kind_of DateTime, user.last_modified
    end
  end

  def test_users_next
    VCR.use_cassette("client/schoool_users_next") do
      users = CleverSDK.client("TEST_TOKEN").school_users("58da8c58155b940248000007")

      assert_kind_of CleverSDK::Data::Users, users
      assert_equal 100, users.count
      assert users.next?

      user = users.first

      assert_kind_of CleverSDK::Data::User, user
      assert_equal "58da8c63d7dc0ca0680003ed", user.id
      assert_equal "58da8a43cc70ab00017a1a87", user.district
      assert_equal "z.steve@example.net", user.email
      assert_equal "Steve", user.first_name
      assert_equal "Ziemann", user.last_name
      refute_empty user.roles
      assert_kind_of DateTime, user.created
      assert_kind_of DateTime, user.last_modified

      next_users = users.next
      assert_kind_of CleverSDK::Data::Users, next_users
      assert_equal 100, next_users.count
      assert next_users.next?

      next_user = next_users.first

      assert_kind_of CleverSDK::Data::User, next_user
      assert_equal "58da8c63d7dc0ca06800048e", next_user.id
      assert_equal "58da8a43cc70ab00017a1a87", next_user.district
      assert_equal "c_anthony@example.com", next_user.email
      assert_equal "Anthony", next_user.first_name
      assert_equal "Corwin", next_user.last_name
      refute_empty next_user.roles
      assert_kind_of DateTime, next_user.created
      assert_kind_of DateTime, next_user.last_modified
    end
  end
end
