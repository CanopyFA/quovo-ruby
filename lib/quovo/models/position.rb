module Quovo
  module Models
    class Position < Base
      using Quovo::Refinements::ToTime

      fields %i(
        account
        asset_class
        cost_basis
        cost_basis_type
        currency
        cusip
        fxrate
        id
        last_purchase_date
        market_code
        portfolio
        portfolio_name
        price
        quantity
        sector
        security_type
        ticker
        ticker_name
        user
        username
        value
      )

      undef :last_purchase_date
      def last_purchase_date
        @last_purchase_date.to_time
      end
    end
  end
end
