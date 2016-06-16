module Quovo
  module Api
    class Brokerages < Base
      using Quovo::Refinements::Cast
      using Quovo::Refinements::Require

      def all
        api(:get, '/brokerages').
          fetch('brokerages').
          cast(Brokerage)
      end

      def find(id)
        id.require!(as: :id)
        api(:get, "/brokerages/#{id}").
          fetch('brokerage').
          cast(Brokerage)
      end
    end
  end
end


