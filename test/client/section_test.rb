require "test_helper"

class CleverApi::Client::SectionTest < CleverApi::Test
  def test_sections
    VCR.use_cassette("section") do
      section = CleverApi.client("TEST_TOKEN").section("58da8c6a894273be68000182")

      assert_kind_of CleverApi::Data::Section, section
      assert_equal "58da8c6a894273be68000182", section.id
      assert_equal "58da8a43cc70ab00017a1a87", section.district
      assert_equal "5970d4de35e9e69741000277", section.course
      assert_equal "58da8c58155b940248000008", section.school
      assert_equal "5b42365868c8d6104f634d34", section.term_id
      assert_equal "Sixth Grade Advisory - Madison - 4", section.name
      assert_equal "homeroom/advisory", section.subject
      assert_equal "", section.section_number
      assert_equal "587", section.sis_id
      assert_equal "6", section.grade
      assert_equal "4", section.period
      assert_equal "A1", section.ext.dig("classroom")
      assert_equal 26, section.students.count
      assert_equal "5faac8b7bc447500a10ae88f", section.teacher
      assert_equal 1, section.teachers.count
      assert_kind_of DateTime, section.created
      assert_kind_of DateTime, section.last_modified
    end
  end
end
