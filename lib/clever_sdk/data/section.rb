# frozen_string_literal: true

module CleverSDK
  module Data
    class Section
      # private
      attr_reader :data, :response

      # private
      def initialize(data, response)
        @data = data
        @response = response
      end

      def id
        data.dig("id")
      end

      def course
        data.dig("course")
      end

      def district
        data.dig("district")
      end

      def school
        data.dig("school")
      end

      def term_id
        data.dig("term_id")
      end

      def name
        data.dig("name")
      end

      def subject
        data.dig("subject")
      end

      def section_number
        data.dig("section_number")
      end

      def sis_id
        data.dig("sis_id")
      end

      def grade
        data.dig("grade")
      end

      def period
        data.dig("period")
      end

      def ext
        data.dig("ext")
      end

      def students
        data.dig("students")
      end

      def teacher
        data.dig("teacher")
      end

      def teachers
        data.dig("teachers")
      end

      def created
        DateTime.parse(data.dig("created"))
      rescue
        nil
      end

      def last_modified
        DateTime.parse(data.dig("last_modified"))
      rescue
        nil
      end

      def inspect
        "#<#{self.class.name}(#{id}) #{name}>"
      end

      alias_method :to_h, :data
    end
  end
end
