require "test_helper"

class CleverApi::Client::TermsTest < CleverApi::Test
  def test_terms
    VCR.use_cassette("terms") do
      terms = CleverApi.client("TEST_TOKEN").terms

      assert_kind_of CleverApi::Data::Terms, terms
      assert_equal 5, terms.count
      refute terms.next?

      term = terms.first

      assert_kind_of CleverApi::Data::Term, term
      assert_equal "5b42365868c8d6104f634d32", term.id
      assert_equal "58da8a43cc70ab00017a1a87", term.district
      assert_equal "S1", term.name
      assert_equal Date.new(2012, 8, 1), term.start_date
      assert_equal Date.new(2012, 12, 1), term.end_date
    end
  end

  def test_terms_with_limit
    VCR.use_cassette("terms_with_limit") do
      terms = CleverApi.client("TEST_TOKEN").terms(limit: 3)

      assert_kind_of CleverApi::Data::Terms, terms
      assert_equal 3, terms.count
      assert terms.next?
    end
  end

  def test_terms_with_starting_after
    VCR.use_cassette("terms_with_starting_after") do
      terms = CleverApi.client("TEST_TOKEN").terms(starting_after: "5b42365868c8d6104f634d34")

      assert_kind_of CleverApi::Data::Terms, terms
      assert_equal 2, terms.count
      refute terms.next?
    end
  end

  def test_terms_next
    VCR.use_cassette("terms_next") do
      terms = CleverApi.client("TEST_TOKEN").terms(limit: 3)

      assert_kind_of CleverApi::Data::Terms, terms
      assert_equal 3, terms.count
      assert terms.next?

      term = terms.first

      assert_kind_of CleverApi::Data::Term, term
      assert_equal "5b42365868c8d6104f634d32", term.id
      assert_equal "58da8a43cc70ab00017a1a87", term.district
      assert_equal "S1", term.name
      assert_equal Date.new(2012, 8, 1), term.start_date
      assert_equal Date.new(2012, 12, 1), term.end_date

      next_terms = terms.next
      assert_kind_of CleverApi::Data::Terms, next_terms
      assert_equal 2, next_terms.count
      refute next_terms.next?

      next_term = next_terms.first

      assert_kind_of CleverApi::Data::Term, next_term
      assert_equal "5b42365868c8d6104f634d35", next_term.id
      assert_equal "58da8a43cc70ab00017a1a87", next_term.district
      assert_equal "Y1", next_term.name
      assert_equal Date.new(2016, 8, 1), next_term.start_date
      assert_equal Date.new(2017, 6, 1), next_term.end_date
    end
  end
end
