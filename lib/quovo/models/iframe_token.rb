module Quovo
  module Models
    class IframeToken < Base
      fields %i(
        user
        token
      )
      def url
        "https://embed.quovo.com/auth/#{token}"
      end
    end
  end
end
