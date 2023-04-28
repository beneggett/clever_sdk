require "test_helper"

class CleverSDK::Authentication::TokensTest < CleverSDK::Test
  def test_tokens
    VCR.use_cassette("authentication/tokens") do
      tokens = CleverSDK.authentication.tokens

      assert_kind_of CleverSDK::Data::Tokens, tokens
      assert_equal 3, tokens.count

      token = tokens.first

      assert_kind_of CleverSDK::Data::Token, token
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
    VCR.use_cassette("authentication/token") do
      token = CleverSDK.authentication.token("58da8a43cc70ab00017a1a87")

      assert_kind_of CleverSDK::Data::Token, token
      assert_equal "62b4e190573f9600080cbf08", token.id
      assert_equal "a9d8f54716263679e484e2de6703c0a514c8dda7", token.access_token
      assert_equal "district", token.owner_type
      assert_equal "58da8a43cc70ab00017a1a87", token.owner_id
      refute_empty token.scopes
      assert_kind_of DateTime, token.created
    end
  end

  def test_tokeninfo
    VCR.use_cassette("authentication/tokeninfo") do
      tokeninfo = CleverSDK.authentication.tokeninfo("ilc_DEMO_TEACHER_TOKEN")

      assert_kind_of CleverSDK::Data::Tokeninfo, tokeninfo
      assert_equal "4c63c1cf623dce82caac", tokeninfo.client_id
      assert_equal 10, tokeninfo.scopes.count
    end
  end

  def test_me
    VCR.use_cassette("authentication/me") do
      me = CleverSDK.authentication.me("ilc_DEMO_TEACHER_TOKEN")

      assert_kind_of CleverSDK::Data::Me, me
      assert_equal "58da8c5da7a7e5a647000094", me.id
      assert_equal "58da8a43cc70ab00017a1a87", me.district
      assert_equal "teacher", me.type
    end
  end
end
