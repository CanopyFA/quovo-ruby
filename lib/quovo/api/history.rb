module Quovo
  module Api
    class History < Base
      include Quovo::Utils::Cast
      include Quovo::Utils::Require
      include Quovo::Utils::Permit

      def for_user(id, params = {})
        require!(id, as: :id)
        permit!(params, :start_date, :end_date, :start_id, :end_id, :count)
        cast(
          api(:get, "/users/#{id}/history", params).fetch('history'),
          Transaction
        ).sort_by(&:sort_key)
      end

      def for_account(id, params = {})
        require!(id, as: :id)
        permit!(params, :start_date, :end_date, :start_id, :end_id, :count)
        cast(
          api(:get, "/accounts/#{id}/history", params).fetch('history'),
          Transaction
        ).sort_by(&:sort_key)
      end

      def for_portfolio(id, params = {})
        require!(id, as: :id)
        permit!(params, :start_date, :end_date, :start_id, :end_id, :count)
        cast(
          api(:get, "/portfolios/#{id}/history", params),
          Transaction
        ).fetch('history').sort_by(&:sort_key)
      end

      def update_transaction(id, params = {})
        require!(id, as: :id)
        permit!(params, :expense_category)
        cast(api(:put, "/history/#{id}", params).fetch('history'), Transaction)
      end
    end
  end
end
