module Quovo
  module Models
    class Account < Base
      include Quovo::Utils::ToTime

      fields %i(
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
        last_good_sync
      )

      undef :opened
      def opened
        to_time(@opened)
      end

      undef :updated
      def updated
        to_time(@updated)
      end

      undef :last_good_sync
      def last_good_sync
        to_time(@last_good_sync)
      end
    end
  end
end
