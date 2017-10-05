module Quovo
  module Utils
    module Permit
      def self.permit!(hash, *keys)
        hash.delete_if { |k, _| !keys.include?(k) }
      end
    end
  end
end
