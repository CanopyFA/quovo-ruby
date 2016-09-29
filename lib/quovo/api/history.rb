module Quovo
  module Api
    class History < Base
      using Quovo::Refinements::Cast
      using Quovo::Refinements::Require
      using Quovo::Refinements::Permit

      def for_user(id, params = {})
        id.require!(as: :id)
        params.permit!(:start_date, :end_date, :start_id, :end_id, :count)
        api(:get, "/users/#{id}/history", params)
          .fetch('history')
          .cast(Transaction)
          .sort_by(&:sort_key)
      end

      def for_account(id, params = {})
        id.require!(as: :id)
        params.permit!(:start_date, :end_date, :start_id, :end_id, :count)
        api(:get, "/accounts/#{id}/history", params)
          .fetch('history')
          .cast(Transaction)
          .sort_by(&:sort_key)
      end

      def for_portfolio(id, params = {})
        id.require!(as: :id)
        params.permit!(:start_date, :end_date, :start_id, :end_id, :count)
        api(:get, "/portfolios/#{id}/history", params)
          .fetch('history')
          .cast(Transaction)
          .sort_by(&:sort_key)
      end

      def update_transaction(id, params = {})
        id.require!(as: :id)
        params.permit!(:expense_category)
        api(:put, "/history/#{id}", params)
          .fetch('history')
          .cast(Transaction)
      end
    end
  end
end
