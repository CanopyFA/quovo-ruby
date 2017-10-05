module Quovo
  module Models
    class Transaction < Base
      include Quovo::Utils::ToTime

      fields %i(
        account
        currency
        cusip
        date
        expense_category
        fees
        fxrate
        id
        is_cancel
        is_pending
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
        to_time(@date)
      end

      def sort_key
        [date, id]
      end
    end
  end
end
