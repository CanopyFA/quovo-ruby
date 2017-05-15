module Quovo
  module Api
    class Webhooks < Base
      using Quovo::Refinements::Cast
      using Quovo::Refinements::Require
      using Quovo::Refinements::Permit

      def all
        api(:get, '/webhooks')
          .fetch('webhooks')
          .cast(Webhook)
      end

      def create(params)
        params
          .permit!(:events, :is_active, :secret, :name, :url)
          .require!(:secret, :name, :url)
        api(:post, '/webhooks', params)
          .fetch('webhook')
          .cast(Webhook)
      end

      def update(name, params)
        name.require!(as: :name)
        params.permit!(:events, :is_active, :secret, :url)
        params[:name] = name
        api(:put, '/webhooks', params)
          .fetch('webhook')
          .cast(Webhook)
      end

      def delete(name)
        name.require!(as: :name)
        api(:delete, '/webhooks', name: name)
      end
    end
  end
end
