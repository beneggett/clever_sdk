require "test_helper"

class CleverSDK::Client::UsersTest < CleverSDK::Test
  def test_users
    VCR.use_cassette("users") do
      users = CleverSDK.client("TEST_TOKEN").users

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
    VCR.use_cassette("users_with_limit") do
      users = CleverSDK.client("TEST_TOKEN").users(limit: 25)

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
    VCR.use_cassette("users_with_starting_after") do
      users = CleverSDK.client("TEST_TOKEN").users(starting_after: "58da8c63d7dc0ca068000478")

      assert_kind_of CleverSDK::Data::Users, users
      assert_equal 100, users.count
      assert users.next?

      user = users.first

      assert_kind_of CleverSDK::Data::User, user
      assert_equal "58da8c63d7dc0ca06800047a", user.id
      assert_equal "58da8a43cc70ab00017a1a87", user.district
      assert_equal "o_george@example.org", user.email
      assert_equal "George", user.first_name
      assert_equal "O'Connell", user.last_name
      refute_empty user.roles
      assert_kind_of DateTime, user.created
      assert_kind_of DateTime, user.last_modified
    end
  end

  def test_users_next
    VCR.use_cassette("users_next") do
      users = CleverSDK.client("TEST_TOKEN").users

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
      assert_equal "58da8c63d7dc0ca06800047a", next_user.id
      assert_equal "58da8a43cc70ab00017a1a87", next_user.district
      assert_equal "o_george@example.org", next_user.email
      assert_equal "George", next_user.first_name
      assert_equal "O'Connell", next_user.last_name
      refute_empty next_user.roles
      assert_kind_of DateTime, next_user.created
      assert_kind_of DateTime, next_user.last_modified
    end
  end
end
