module Quovo
  module Models
    class Portfolio < Base
      using Quovo::Refinements::ToTime
      CATEGORIES = {
        'Investment' => %w(
          401a 401k 403b 457b 529
          Brokerage\ Account
          Education\ Savings\ Account
          Health\ Reimbursement\ Arrangement
          Health\ Savings\ Account
          IRA
          Minor\ Custodial\ Account
          Non-Taxable\ Brokerage\ Account
          Pension
          Profit\ Sharing\ Plan
          Roth\ 401k Roth\ IRA SEP\ IRA Simple\ IRA
          Stock\ Plan
          Thrift\ Savings\ Plan
          Variable\ Annuity
        ),
        'Banking'    => %w(Checking Credit\ Card Savings),
        'Insurance'  => %w(
          Annuity Fixed\ Annuity Insurance
          Term\ Life\ Insurance
          Universal\ Life\ Insurance
          Variable\ Life\ Insurance
          Whole\ Life\ Insurance
        ),
        'Loan'       => %w(Auto\ Loan Loan Mortgage Student\ Loan),
        'Other'      => %w(Alternative Limited\ Partnership Misc Real\ Estate),
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
        portfolio_type_confidence
      )

      undef :last_change
      def last_change
        @last_change.to_time
      end
    end
  end
end
