# frozen_string_literal: true

module CleverSDK
  module Data
    class User
      class StudentRole
        # private
        def initialize(user)
          @user = user
          @role = @user.roles.dig("student")
        end

        def sis_id
          @role.dig("sis_id")
        end
      end
    end
  end
end
