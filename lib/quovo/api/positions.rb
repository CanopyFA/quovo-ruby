module Quovo
  module Api
    class Positions < Base
      using Quovo::Refinements::Cast
      using Quovo::Refinements::Permit
      using Quovo::Refinements::Require

      def for_user(id)
        id.require!(as: :id)
        api(:get, "/users/#{id}/positions")
          .fetch('positions')
          .cast(Position)
      end

      def for_account(id)
        id.require!(as: :id)
        api(:get, "/accounts/#{id}/positions")
          .fetch('positions')
          .cast(Position)
      end

      def for_portfolio(id)
        id.require!(as: :id)
        api(:get, "/portfolios/#{id}/positions")
          .fetch('positions')
          .cast(Position)
      end
    end
  end
end
