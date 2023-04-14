require "test_helper"

class CleverSDK::Client::TermTest < CleverSDK::Test
  def test_terms
    VCR.use_cassette("term") do
      term = CleverSDK.client("TEST_TOKEN").term("5b42365868c8d6104f634d32")

      assert_kind_of CleverSDK::Data::Term, term
      assert_equal "5b42365868c8d6104f634d32", term.id
      assert_equal "58da8a43cc70ab00017a1a87", term.district
      assert_equal "S1", term.name
      assert_equal Date.new(2012, 8, 1), term.start_date
      assert_equal Date.new(2012, 12, 1), term.end_date
    end
  end
end
