module Quovo
  module Api
    class IframeToken < Base
      using Quovo::Refinements::Cast
      using Quovo::Refinements::Require

      def create(user_id)
        user_id.require!(as: :user_id)
        api(:post, '/iframe_token', user: user_id)
          .fetch('iframe_token')
          .cast(Quovo::Models::IframeToken)
      end
    end
  end
end
