require "test_helper"

class CleverApi::Authentication::TokensTest < CleverApi::Test
  def test_tokens
    VCR.use_cassette("tokens") do
      tokens = CleverApi.authentication.tokens

      assert_kind_of CleverApi::Data::Tokens, tokens
      assert_equal 3, tokens.count

      token = tokens.first

      assert_kind_of CleverApi::Data::Token, token
      assert_equal "62b4e190573f9600080cbf08", token.id
      assert_equal "a9d8f54716263679e484e2de6703c0a514c8dda7", token.access_token
      assert_equal "district", token.owner_type
      assert_equal "58da8a43cc70ab00017a1a87", token.owner_id
      assert_equal 5, token.scopes.count
      assert_includes token.scopes, "read:district_admins_basic"
      assert_includes token.scopes, "read:school_admins_basic"
      assert_includes token.scopes, "read:students_basic"
      assert_includes token.scopes, "read:teachers_basic"
      assert_includes token.scopes, "read:user_id"
      assert_kind_of DateTime, token.created
    end
  end

  def test_token
    VCR.use_cassette("token") do
      token = CleverApi.authentication.token("58da8a43cc70ab00017a1a87")

      assert_kind_of CleverApi::Data::Token, token
      assert_equal "62b4e190573f9600080cbf08", token.id
      assert_equal "a9d8f54716263679e484e2de6703c0a514c8dda7", token.access_token
      assert_equal "district", token.owner_type
      assert_equal "58da8a43cc70ab00017a1a87", token.owner_id
      refute_empty token.scopes
      assert_kind_of DateTime, token.created
    end
  end
end
