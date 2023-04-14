require "test_helper"

class CleverSDK::Client::SectionsTest < CleverSDK::Test
  def test_sections
    VCR.use_cassette("sections") do
      sections = CleverSDK.client("TEST_TOKEN").sections

      assert_kind_of CleverSDK::Data::Sections, sections
      assert_equal 100, sections.count
      assert sections.next?

      section = sections.first

      assert_kind_of CleverSDK::Data::Section, section
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

  def test_sections_with_limit
    VCR.use_cassette("sections_with_limit") do
      sections = CleverSDK.client("TEST_TOKEN").sections(limit: 25)

      assert_kind_of CleverSDK::Data::Sections, sections
      assert_equal 25, sections.count
      assert sections.next?
    end
  end

  def test_sections_with_starting_after
    VCR.use_cassette("sections_with_starting_after") do
      sections = CleverSDK.client("TEST_TOKEN").sections(starting_after: "58da8c6b894273be68000255")

      assert_kind_of CleverSDK::Data::Sections, sections
      assert_equal 100, sections.count
      assert sections.next?

      section = sections.first

      assert_kind_of CleverSDK::Data::Section, section
      assert_equal "58da8c6b894273be68000256", section.id
      assert_equal "58da8a43cc70ab00017a1a87", section.district
      assert_equal "5970d4dd35e9e69741000244", section.course
      assert_equal "58da8c58155b940248000008", section.school
      assert_equal "5b42365868c8d6104f634d34", section.term_id
      assert_equal "Media Arts, Class 701 - Konopelski - 9", section.name
      assert_equal "arts and music", section.subject
      assert_equal "", section.section_number
      assert_equal "800", section.sis_id
      assert_equal "7", section.grade
      assert_equal "9", section.period
      assert_equal "A2", section.ext.dig("classroom")
      assert_equal 26, section.students.count
      assert_equal "5faac8b7bc447500a10ae88d", section.teacher
      assert_equal 1, section.teachers.count
      assert_kind_of DateTime, section.created
      assert_kind_of DateTime, section.last_modified
    end
  end

  def test_sections_next
    VCR.use_cassette("sections_next") do
      sections = CleverSDK.client("TEST_TOKEN").sections

      assert_kind_of CleverSDK::Data::Sections, sections
      assert_equal 100, sections.count
      assert sections.next?

      section = sections.first

      assert_kind_of CleverSDK::Data::Section, section
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

      next_sections = sections.next
      assert_kind_of CleverSDK::Data::Sections, next_sections
      assert_equal 100, next_sections.count
      assert next_sections.next?

      next_section = next_sections.first

      assert_kind_of CleverSDK::Data::Section, next_section
      assert_equal "58da8c6b894273be68000256", next_section.id
      assert_equal "58da8a43cc70ab00017a1a87", next_section.district
      assert_equal "5970d4dd35e9e69741000244", next_section.course
      assert_equal "58da8c58155b940248000008", next_section.school
      assert_equal "5b42365868c8d6104f634d34", next_section.term_id
      assert_equal "Media Arts, Class 701 - Konopelski - 9", next_section.name
      assert_equal "arts and music", next_section.subject
      assert_equal "", next_section.section_number
      assert_equal "800", next_section.sis_id
      assert_equal "7", next_section.grade
      assert_equal "9", next_section.period
      assert_equal "A2", next_section.ext.dig("classroom")
      assert_equal 26, next_section.students.count
      assert_equal "5faac8b7bc447500a10ae88d", next_section.teacher
      assert_equal 1, next_section.teachers.count
      assert_kind_of DateTime, next_section.created
      assert_kind_of DateTime, next_section.last_modified
    end
  end
end
