# frozen_string_literal: true

module CleverApi
  module Data
    class Token # < Base
      attr_reader :uid,
                  :created,
                  :owner_id,
                  :owner_type,
                  :access_token,
                  :scopes

      def initialize(attributes = {})
        @uid          = attributes.dig('id')
        @created      = attributes.dig('created')
        @owner_id     = attributes.dig('owner', 'id')
        @owner_type   = attributes.dig('owner', 'type')
        @access_token = attributes.dig('access_token')
        @scopes       = attributes.dig('scopes')
      end
    end
  end
end

# example response 
# { 
#   "id"=>"63e673d9d016950008e5b5b2",
#   "created"=>"2023-02-10T16:42:01.701Z",
#   "owner"=>{"type"=>"district", "id"=>"63e673d91c05c2527736ba41"},
#   "access_token"=>"93149df29f4e00a9506d03f4bdc7e32610161539",
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
