module Quovo
  module Models
    class Account < Base
      using Quovo::Refinements::ToTime

      fields %i[
        id
        nickname
        is_inactive
        brokerage
        brokerage_name
        user
        username
        status
        value
        config_instructions
        failures
        update_count
        opened
        updated
      ]

      undef :opened
      def opened
        @opened.to_time
      end

      undef :updated
      def updated
        @updated.to_time
      end
    end
  end
end
