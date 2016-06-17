module Quovo
  module Api
    class Users < Base
      using Quovo::Refinements::Cast
      using Quovo::Refinements::Require
      using Quovo::Refinements::Permit

      def all
        api(:get, '/users')
          .fetch('users')
          .cast(User)
      end

      def find(id)
        id.require!(as: :id)
        api(:get, "/users/#{id}")
          .fetch('user')
          .cast(User)
      end

      def create(params)
        params
          .permit!(:username, :name, :email, :phone)
          .require!(:username)
        api(:post, '/users', params)
          .fetch('user')
          .cast(User)
      end

      def update(id, params)
        id.require!(as: :id)
        params.permit!(:name, :email, :phone)
        api(:put, "/users/#{id}", params)
          .fetch('user')
          .cast(User)
      end

      def delete(id)
        id.require!(as: :id)
        api(:delete, "/users/#{id}")
      end
    end
  end
end
