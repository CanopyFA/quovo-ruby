module Quovo
  module Models
    class Position < Base
      include Quovo::Utils::ToTime

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
        proxy_ticker
        proxy_confidence
        quantity
        sector
        security_type
        security_type_confidence
        ticker
        ticker_name
        user
        username
        value
      )

      undef :last_purchase_date
      def last_purchase_date
        to_time(@last_purchase_date)
      end
    end
  end
end
