module Quovo
  module Api
    class Extras < Base
      using Quovo::Refinements::Cast
      using Quovo::Refinements::Require

      def for_portfolio(id)
        id.require!(as: :id)
        api(:get, "/portfolios/#{id}/extras")
          .fetch('extras')
          .cast(Extra)
      end
    end
  end
end
