# frozen_string_literal: true

module CleverSDK
  module Data
    class District
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

      def name
        data.dig("name")
      end

      def mdr_number
        data.dig("mdr_number")
      end

      def nces_id
        data.dig("nces_id")
      end

      def sis_type
        data.dig("sis_type")
      end

      def state
        data.dig("state")
      end

      def last_sync
        DateTime.parse(data.dig("last_sync"))
      rescue
        nil
      end

      def portal_url
        data.dig("portal_url")
      end

      def login_methods
        Array(data.dig("login_methods"))
      end

      def launch_date
        Date.parse(data.dig("launch_date"))
      rescue
        nil
      end

      def pause_start
        Date.parse(data.dig("pause_start"))
      rescue
        nil
      end

      def pause_end
        Date.parse(data.dig("pause_end"))
      rescue
        nil
      end

      def district_contact
        Contact.new(data.dig("district_contact"))
      end

      def error
        data.dig("error")
      end

      def inspect
        "#<#{self.class.name}(#{id}) #{name}>"
      end

      alias_method :to_h, :data

      class Contact
        attr_reader :data

        # private
        def initialize(data)
          @data = data
        end

        def id
          data.dig("id")
        end

        def district_id
          data.dig("district_id")
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

        def title
          data.dig("title")
        end

        def inspect
          "#<#{self.class.name}(#{id}) #{first_name} #{last_name}>"
        end

        alias_method :to_h, :data
      end
    end
  end
end
