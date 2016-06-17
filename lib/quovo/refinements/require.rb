module Quovo
  module Refinements
    module Require
      refine Object do
        def require!(*keys, as: 'parameter')
          case self
          when Hash
            missing = keys - self.keys
            if missing.any?
              raise Quovo::ParamsError, "Bad params list. Expected: #{keys}, actual #{self.keys}"
            end
            keys.each { |k| self[k].require!(as: k) }
          when NilClass
            raise Quovo::ParamsError, "#{as} cannot be nil!"
          end
        end
      end
    end
  end
end
