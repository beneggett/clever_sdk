# frozen_string_literal: true

module CleverSDK
  module Data
    class User
      class StaffRole
        # private
        def initialize(user)
          @user = user
          @role = @user.roles.dig("staff")
        end

        def legacy_id
          @role.dig("legacy_id")
        end
      end
    end
  end
end
