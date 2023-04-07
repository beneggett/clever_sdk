# frozen_string_literal: true

module CleverApi
  module Data
    class Token
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

      def created
        DateTime.parse(data.dig("created"))
      rescue
        nil
      end

      def owner_id
        data.dig("owner", "id")
      end

      def owner_type
        data.dig("owner", "type")
      end

      def access_token
        data.dig("access_token")
      end

      def scopes
        data.dig("scopes")
      end

      def inspect
        "#<#{self.class.name}(#{id}) #{access_token}>"
      end

      alias_method :to_h, :data
    end
  end
end

# example response
# {
#   "id"=>"63e673d9d016950008e5b5b2",
#   "created"=>"2023-02-10T16:42:01.701Z",
#   "owner"=>{"type"=>"district", "id"=>"63e673d91c05c2527736ba41"},
#   "access_token"=>"TEST_TOKEN",
#   "scopes"=>
#    ["read:district_admins",
#     "read:districts",
#     "read:resources",
#     "read:school_admins",
#     "read:schools",
#     "read:sections",
#     "read:student_contacts",
#     "read:students",
#     "read:teachers",
#     "read:user_id"]
# }
