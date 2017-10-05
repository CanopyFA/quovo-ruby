module Quovo
  module Utils
    module Compact
      def self.compact!(hash)
        hash.delete_if { |_, value| value.nil? }
      end
    end
  end
end
