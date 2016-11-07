module Quovo
  module Models
    class Portfolio < Base
      using Quovo::Refinements::ToTime
      CATEGORIES = {
        'Investment' => %w(
          401a 401k 403b 457b 529
          Brokerage\ Account
          Education\ Savings\ Account
          Health\ Savings\ Account
          IRA
          Non-Taxable\ Brokerage\ Account
          Pension
          Roth\ IRA Roth\ 401k Simple\ IRA SEP\ IRA
          Thrift\ Savings\ Plan
          Profit\ Sharing\ Plan
          Stock\ Plan
          Minor\ Custodial\ Account
        ),
        'Banking'    => %w(Checking Credit\ Card Savings),
        'Insurance'  => %w(Annuity Fixed\ Annuity Insurance Variable\ Annuity),
        'Loan'       => %w(Loan Mortgage Student\ Loan),
        'Unknown'    => %w(Unknown)
      }.freeze

      fields %i(
        id
        account
        brokerage
        brokerage_name
        description
        is_inactive
        is_taxable
        last_change
        nickname
        owner_type
        portfolio_name
        portfolio_type
        portfolio_category
        update_count
        user
        username
        value
      )

      undef :last_change
      def last_change
        @last_change.to_time
      end
    end
  end
end
