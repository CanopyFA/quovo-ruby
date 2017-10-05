module Quovo
  module Api
    class Accounts < Base
      include Quovo::Utils::Cast
      include Quovo::Utils::Require
      include Quovo::Utils::Permit

      def all
        cast(api(:get, '/accounts').fetch('accounts'), Account)
      end

      def find(id)
        require!(id, as: :id)
        cast(api(:get, "/accounts/#{id}").fetch('account'), Account)
      end

      def create(params)
        require!(params, :user, :brokerage, :username, :password)
        cast(api(:post, '/accounts', params).fetch('account'), Account)
      end

      def update(id, params)
        require!(id, as: :id)
        permit!(params, :brokerage, :username, :password)
        require!(params, :username, :password) if params[:username] || params[:password]
        cast(api(:put, "/accounts/#{id}", params).fetch('account'), Account)
      end

      def delete(id)
        require!(id, as: :id)
        api(:delete, "/accounts/#{id}")
      end

      def for_user(id)
        require!(id, as: :id)
        cast(api(:get, "/users/#{id}/accounts").fetch('accounts'), Account)
      end

      def sync!(id)
        require!(id, as: :id)
        cast(api(:post, "/accounts/#{id}/sync").fetch('sync'), Sync)
      end

      def sync(id)
        require!(id, as: :id)
        cast(api(:get, "/accounts/#{id}/sync").fetch('sync'), Sync)
      end
    end
  end
end
