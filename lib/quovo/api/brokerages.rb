module Quovo
  module Api
    class Brokerages < Base
      include Quovo::Utils::Cast
      include Quovo::Utils::Require

      def all
        cast(api(:get, '/brokerages').fetch('brokerages'), Brokerage)
      end

      def find(id)
        require!(id, as: :id)
        cast(api(:get, "/brokerages/#{id}").fetch('brokerage'), Brokerage)
      end
    end
  end
end
