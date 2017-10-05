module Quovo
  module Utils
    module Require
      def require!(object, *keys, as: 'parameter')
        Quovo::Utils::Require.require!(object, *keys, as: 'parameter')
      end

      def self.require!(object, *keys, as: 'parameter')
        case object
        when Hash
          missing = keys - object.keys
          if missing.any?
            raise Quovo::ParamsError, "Bad params list. Expected: #{keys}, actual #{object.keys}"
          end
          keys.each { |k| require!(object[k], as: k) }
        when NilClass
          raise Quovo::ParamsError, "#{as} cannot be nil!"
        end
      end
    end
  end
end
