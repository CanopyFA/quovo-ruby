module Quovo
  module Api
    class Users < Base
      include Quovo::Utils::Cast
      include Quovo::Utils::Require
      include Quovo::Utils::Permit

      def all
        cast(
          api(:get, '/users').fetch('users'),
          User
        )
      end

      def find(id)
        require!(id, as: :id)
        cast(
          api(:get, "/users/#{id}").fetch('user'),
          User
        )
      end

      def create(params)
        require!(permit!(params, :username, :name, :email, :phone), :username)
        cast(
          api(:post, '/users', params).fetch('user'),
          User
        )
      end

      def update(id, params)
        require!(id, as: :id)
        permit!(params, :name, :email, :phone)
        cast(
          api(:put, "/users/#{id}", params).fetch('user'),
          User
        )
      end

      def delete(id)
        require!(id, as: :id)
        api(:delete, "/users/#{id}")
      end
    end
  end
end
