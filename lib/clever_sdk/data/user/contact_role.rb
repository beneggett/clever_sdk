# frozen_string_literal: true

module CleverSDK
  module Data
    class User
      class ContactRole
        # private
        def initialize(user)
          @user = user
          @role = @user.roles.dig("contact")
        end

        def legacy_id
          @role.dig("legacy_id")
        end
      end
    end
  end
end
