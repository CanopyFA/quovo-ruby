module Quovo
  module Models
    class Transaction < Base
      using Quovo::Refinements::ToTime

      fields %i(
        account
        currency
        cusip
        date
        expense_category
        fees
        fxrate
        id
        memo
        portfolio
        price
        quantity
        ticker
        ticker_name
        tran_category
        tran_type
        user
        value
      )

      undef :date
      def date
        @date.to_time
      end

      def sort_key
        [date, id]
      end
    end
  end
end
