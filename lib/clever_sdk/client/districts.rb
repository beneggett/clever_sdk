# frozen_string_literal: true

require "clever_sdk/data/districts"

module CleverSDK
  class Client
    module Districts
      # count - acceptable values are nil, :true, :false, :undefined
      def districts(count: nil)
        response = api.districts(access_token: access_token, count: count)
        CleverSDK::Data::Districts.new(response)
      end

      def district(id)
        response = api.district(access_token: access_token, id: id)
        data = response.body.dig("data")
        CleverSDK::Data::District.new(data, response)
      end
    end
  end
end
