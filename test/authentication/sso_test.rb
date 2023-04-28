require "test_helper"

class CleverSDK::Authentication::SSOTest < CleverSDK::Test
  def test_sso
    VCR.use_cassette("authentication/sso") do
      sso = CleverSDK.authentication.sso("notarealssotoken")
      assert sso.me
      assert sso.user
    end
  end
end
