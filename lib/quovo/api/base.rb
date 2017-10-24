module Quovo
  module Api
    class Base
      include Quovo::Models
      include Quovo::Request

      def initialize(token = Quovo::Token.new)
        @token = token
      end

      def api(method, path, params = {})
        format = case method
                 when :delete
                   :plain
                 else
                   :json
                 end

        request(method, path, params, format) do |req|
          req['Authorization'] = "Bearer #{token.get}"
          if Quovo.current_scope[:advisor].present?
            req['Advisor'] = Quovo.current_scope[:advisor_id].to_s
          end
          req
        end || {}
      end

      attr_reader :token
    end
  end
end
