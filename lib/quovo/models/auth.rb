module Quovo
  module Models
    class Auth < Base
      using Quovo::Refinements::Cast
      using Quovo::Refinements::ToTime

      fields %i(
        balance
        brokerage
        brokerage_name
        id
        last_good_auth
        updated
        user
        username
        portfolios
      )

      undef :last_good_auth
      def last_good_auth
        @last_good_auth.to_time
      end

      undef :updated
      def updated
        @updated.to_time
      end

      undef :portfolios
      def portfolios
        @portfolios.cast(Portfolio)
      end

    end
  end
end
