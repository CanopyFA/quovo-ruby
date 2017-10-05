module Quovo
  module Api
    class Positions < Base
      include Quovo::Utils::Cast
      include Quovo::Utils::Permit
      include Quovo::Utils::Require

      def for_user(id)
        require!(id, as: :id)
        cast(
          api(:get, "/users/#{id}/positions").fetch('positions'),
          Position
        )
      end

      def for_account(id)
        require!(id, as: :id)
        cast(
          api(:get, "/accounts/#{id}/positions").fetch('positions'),
          Position
        )
      end

      def for_portfolio(id)
        require!(id, as: :id)
        cast(
          api(:get, "/portfolios/#{id}/positions").fetch('positions'),
          Position
        )
      end
    end
  end
end
