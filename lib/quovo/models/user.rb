module Quovo
  module Models
    class User < Base
      fields %i[
        id
        username
        email
        name
        phone
        value
      ]
    end
  end
end
