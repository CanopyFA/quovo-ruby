module Quovo
  module Api
    class IframeToken < Base
      include Quovo::Utils::Cast
      include Quovo::Utils::Require

      def create(user_id)
        require!(user_id, as: :user_id)
        cast(
          api(:post, '/iframe_token', user: user_id).fetch('iframe_token'),
          Quovo::Models::IframeToken
        )
      end
    end
  end
end
