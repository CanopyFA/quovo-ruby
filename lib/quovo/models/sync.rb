module Quovo
  module Models
    class Sync < Base
      using Quovo::Refinements::Cast

      fields %i[
        account
        has_realtime
        config_instructions
        progress
        status
      ]

      undef :progress
      def progress
        @progress.cast(Progress)
      end
    end
  end
end
