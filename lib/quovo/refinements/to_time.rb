module Quovo
  module Refinements
    module ToTime
      refine Object do
        def to_time
          case self
          when String
            Time.parse(self + ' UTC')
          when NilClass
            nil
          else
            raise "cannot convert #{self.inspect} to time"
          end
        end
      end
    end
  end
end
