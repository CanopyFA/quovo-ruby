module Quovo
  module Models
    class Sync < Base
      include Quovo::Utils::Cast

      fields %i(
        account
        has_realtime
        config_instructions
        progress
        status
      )

      undef :progress
      def progress
        cast(@progress, Progress)
      end
    end
  end
end
