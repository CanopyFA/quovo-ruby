module Quovo
  module Api
    class Accounts < Base
      using Quovo::Refinements::Cast
      using Quovo::Refinements::Require
      using Quovo::Refinements::Permit

      def all
        api(:get, '/accounts')
          .fetch('accounts')
          .cast(Account)
      end

      def find(id)
        id.require!(as: :id)
        api(:get, "/accounts/#{id}")
          .fetch('account')
          .cast(Account)
      end

      def create(params)
        params.require!(:user, :brokerage, :username, :password)
        api(:post, '/accounts', params)
          .fetch('account')
          .cast(Account)
      end

      def update(id, params)
        id.require!(as: :id)
        params
          .permit!(:brokerage, :username, :password)
        params.require!(:username, :password) if params[:username] || params[:password]
        api(:put, "/accounts/#{id}", params)
          .fetch('account')
          .cast(Account)
      end

      def delete(id)
        id.require!(as: :id)
        api(:delete, "/accounts/#{id}")
      end

      def for_user(id)
        id.require!(as: :id)
        api(:get, "/users/#{id}/accounts")
          .fetch('accounts')
          .cast(Account)
      end

      def sync!(id, options={})
        id.require!(as: :id)
        options.select! { |k,v| v == true }
        api(:post, "/accounts/#{id}/sync", options)
          .fetch('sync')
          .cast(Sync)
      end

      def sync(id)
        id.require!(as: :id)
        api(:get, "/accounts/#{id}/sync")
          .fetch('sync')
          .cast(Sync)
      end

      def auth(id)
        id.require!(as: :id)
        api(:get, "/accounts/#{id}/auth")
          .fetch('auth')
          .cast(Auth)
      end

    end
  end
end
