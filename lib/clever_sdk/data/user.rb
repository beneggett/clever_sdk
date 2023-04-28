# frozen_string_literal: true

require "clever_sdk/data/user/contact_role"
require "clever_sdk/data/user/district_admin_role"
require "clever_sdk/data/user/staff_role"
require "clever_sdk/data/user/student_role"
require "clever_sdk/data/user/teacher_role"
require "clever_sdk/data/user/refs"

module CleverSDK
  module Data
    class User
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

      def district
        data.dig("district")
      end

      def first_name
        data.dig("name", "first")
      end

      def middle_name
        data.dig("name", "middle")
      end

      def last_name
        data.dig("name", "last")
      end

      def email
        data.dig("email")
      end

      def roles
        data.dig("roles")
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

      def contact?
        !roles.dig("contact").nil?
      end

      def contact
        return unless contact?

        @contact ||= CleverSDK::Data::User::ContactRole.new(self)
      end

      def district_admin?
        !roles.dig("district_admin").nil?
      end

      def district_admin
        return unless district_admin?

        @district_admin ||= CleverSDK::Data::User::DistrictAdminRole.new(self)
      end

      def staff?
        !roles.dig("staff").nil?
      end

      def staff
        return unless staff?

        @staff ||= CleverSDK::Data::User::StaffRole.new(self)
      end

      def teacher?
        !roles.dig("teacher").nil?
      end

      def teacher
        return unless teacher?

        @teacher ||= CleverSDK::Data::User::TeacherRole.new(self)
      end

      def student?
        !roles.dig("student").nil?
      end

      def student
        return unless student?

        @student ||= CleverSDK::Data::User::StudentRole.new(self)
      end

      def refs
        @refs ||= CleverSDK::Data::User::Refs.new(self)
      end

      def inspect
        "#<#{self.class.name}(#{id}) #{first_name} #{last_name}>"
      end

      alias_method :to_h, :data
    end
  end
end
