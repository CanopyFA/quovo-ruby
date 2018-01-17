module Quovo
  module Models
    class Brokerage < Base
      fields %i(
        id
        is_test
        name
        notes
        password
        username
        website
        popularity_score
        status
        country_code
      )
    end
  end
end
