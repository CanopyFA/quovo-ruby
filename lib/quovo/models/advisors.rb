module Quovo
  module Models
    class Advisor < Base
      fields %i(
        id
        username
        email
        name
      )
    end
  end
end
