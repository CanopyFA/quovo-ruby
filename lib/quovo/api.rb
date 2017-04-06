module Quovo
  module Api
    def brokerages
      @brokerages ||= Quovo::Api::Brokerages.new
    end

    def accounts
      @accounts ||= Quovo::Api::Accounts.new
    end

    def challenges
      @challenges ||= Quovo::Api::Challenges.new
    end

    def portfolios
      @portfolios ||= Quovo::Api::Portfolios.new
    end

    def users
      @users ||= Quovo::Api::Users.new
    end

    def positions
      @positions ||= Quovo::Api::Positions.new
    end

    def history
      @history ||= Quovo::Api::History.new
    end

    def iframe_token
      @iframe_token ||= Quovo::Api::IframeToken.new
    end

    def webhooks
      @webhooks ||= Quovo::Api::Webhooks.new
    end
  end
end
