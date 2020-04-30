module Quovo
  module Api
    class Webhooks < Base
      include Quovo::Utils::Cast
      include Quovo::Utils::Require
      include Quovo::Utils::Permit

      def all
        cast(
          api(:get, '/webhooks').fetch('webhooks'),
          Webhook
        )
      end

      def create(params)
        require!(
          permit!(params, :events, :is_active, :secret, :name, :url),
          :secret, :name, :url
        )
        cast(
          api(:post, '/webhooks', params).fetch('webhook'),
          Webhook
        )
      end

      def update(name, params)
        require!(name, as: :name)
        permit!(params, :events, :is_active, :secret, :url)
        params[:name] = name
        cast(
          api(:put, '/webhooks', params).fetch('webhook'),
          Webhook
        )
      end

      def delete(name)
        require!(name, as: :name)
        api(:delete, '/webhooks', name: name)
      end
    end
  end
end
