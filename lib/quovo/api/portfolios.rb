module Quovo
  module Api
    class Portfolios < Base
      using Quovo::Utils::Cast
      using Quovo::Utils::Compact
      using Quovo::Utils::Permit
      using Quovo::Utils::Require

      def all
        cast(api(:get, '/portfolios').fetch('portfolios'), Portfolio)
      end

      def find(id)
        require!(id, as: :id)
        cast(api(:get, "/portfolios/#{id}").fetch('portfolio'), Portfolio)
      end

      def update(id, params)
        require!(id, as: :id)
        permit!(params, :nickname, :portfolio_type, :is_inactive).compact!
        cast(
          api(:put, "/portfolios/#{id}", params).fetch('portfolio'),
          Portfolio
        )
      end

      def for_user(id)
        require!(id, as: :id)
        cast(
          api(:get, "/users/#{id}/portfolios").fetch('portfolios'),
          Portfolio
        )
      end

      def for_account(id)
        require!(id, as: :id)
        cast(
          api(:get, "/accounts/#{id}/portfolios").fetch('portfolios'),
          Portfolio
        )
      end
    end
  end
end
