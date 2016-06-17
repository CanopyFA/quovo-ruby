module Quovo
  module Models
    class Progress < Base
      fields %i(
        message
        percent
        state
      )
    end
  end
end
