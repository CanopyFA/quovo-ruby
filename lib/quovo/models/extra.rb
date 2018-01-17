module Quovo
  module Models
    class Extra < Base
      using Quovo::Refinements::ToTime

      fields %i(
        casp_apr
        credit_limit
        due_date
        interest_rate
        is_overdue
        last_payment
        last_payment_date
        last_statement_balance
        last_statement_date
        loan_type
        maturity_type
        min_payment
        original_principal
        origination_date
        portfolio
        ytd_interest_paid
        ytd_principal_paid
      )

      undef :due_date
      def due_date
        @due_date.to_time
      end

      undef :last_payment_date
      def last_payment_date
        @last_payment_date.to_time
      end

      undef :last_statement_date
      def last_statement_date
        @last_statement_date.to_time
      end

      undef :origination_date
      def origination_date
        @origination_date.to_time
      end
    end
  end
end
