module Quovo
  module Utils
    module Permit
      def permit!(hash, *keys)
        Quovo::Utils::Permit.permit!(hash, *keys)
      end

      def self.permit!(hash, *keys)
        hash.delete_if { |k, _| !keys.include?(k) }
      end
    end
  end
end
