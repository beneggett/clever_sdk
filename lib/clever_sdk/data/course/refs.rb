# frozen_string_literal: true

module CleverSDK
  module Data
    class Course
      class Refs
        # private
        def initialize(course)
          @course = course
        end

        def district
          client.course_district(@course.id)
        end

        def resources(limit: nil, starting_after: nil, ending_before: nil)
          client.course_resources(@course.id, limit: limit, starting_after: starting_after, ending_before: ending_before)
        end

        def schools(limit: nil, starting_after: nil, ending_before: nil)
          client.course_schools(@course.id, limit: limit, starting_after: starting_after, ending_before: ending_before)
        end

        def sections(limit: nil, starting_after: nil, ending_before: nil)
          client.course_sections(@course.id, limit: limit, starting_after: starting_after, ending_before: ending_before)
        end

        private

        def client
          @client ||= CleverSDK::Client.new(@course.response.access_token)
        end
      end
    end
  end
end
