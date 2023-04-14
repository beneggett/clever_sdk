require "test_helper"

class CleverSDKTest < CleverSDK::Test
  def test_that_it_has_a_version_number
    refute_nil ::CleverSDK::VERSION
  end
end
