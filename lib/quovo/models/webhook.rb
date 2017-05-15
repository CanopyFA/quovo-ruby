module Quovo
  module Models
    class Webhook < Base
      fields %i(
        events
        is_active
        secret
        name
        url
      )
    end
  end
end
