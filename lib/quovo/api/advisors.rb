module Quovo
  module Api
    class Advisors < Base
      include Quovo::Utils::Cast
      include Quovo::Utils::Require
      include Quovo::Utils::Permit

      def all
        cast(
          api(:get, '/advisors').fetch('advisors'),
          Advisor
        )
      end

      def find(id)
        require!(id, as: :id)
        cast(
          api(:get, "/advisors/#{id}").fetch('advisor'),
          Advisor
        )
      end

      def create(params)
        require!(permit!(params, :username, :name, :email), :username)
        cast(
          api(:post, '/advisors', params).fetch('advisor'),
          Advisor
        )
      end

      def update(id, params)
        require!(id, as: :id)
        permit!(params, :name, :email, :username)
        cast(
          api(:put, "/advisors/#{id}", params).fetch('advisor'),
          Advisor
        )
      end

    end
  end
end
