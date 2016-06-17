module Quovo
  module Api
    class Portfolios < Base
      using Quovo::Refinements::Cast
      using Quovo::Refinements::Compact
      using Quovo::Refinements::Permit
      using Quovo::Refinements::Require

      def all
        api(:get, '/portfolios')
          .fetch('portfolios')
          .cast(Portfolio)
      end

      def find(id)
        id.require!(as: :id)
        api(:get, "/portfolios/#{id}")
          .fetch('portfolio')
          .cast(Portfolio)
      end

      def update(id, params)
        id.require!(as: :id)
        params
          .permit!(:nickname, :portfolio_type, :is_inactive)
          .compact!
        api(:put, "/portfolios/#{id}", params)
          .fetch('portfolio')
          .cast(Portfolio)
      end

      def for_user(id)
        id.require!(as: :id)
        api(:get, "/users/#{id}/portfolios")
          .fetch('portfolios')
          .cast(Portfolio)
      end

      def for_account(id)
        id.require!(as: :id)
        api(:get, "/accounts/#{id}/portfolios")
          .fetch('portfolios')
          .cast(Portfolio)
      end
    end
  end
end
