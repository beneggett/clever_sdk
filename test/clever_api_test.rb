require "test_helper"

class CleverApiTest < CleverApi::Test
  def test_that_it_has_a_version_number
    refute_nil ::CleverApi::VERSION
  end
end
