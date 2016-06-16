module Quovo
  module Refinements
    module Compact
      refine Hash do
        def compact!
          self.delete_if { |_, value| value.nil? }
        end
      end
    end
  end
end