require "test_helper"

class CleverSDK::Client::UserTest < CleverSDK::Test
  def test_users
    VCR.use_cassette("user") do
      user = CleverSDK.client("TEST_TOKEN").user("58da8c63d7dc0ca068000478")

      assert_kind_of CleverSDK::Data::User, user
      assert_equal "58da8c63d7dc0ca068000478", user.id
      assert_equal "58da8a43cc70ab00017a1a87", user.district
      assert_equal "james.s@example.com", user.email
      assert_equal "James", user.first_name
      assert_equal "Spencer", user.last_name
      refute_empty user.roles
      assert_kind_of DateTime, user.created
      assert_kind_of DateTime, user.last_modified
    end
  end
end
