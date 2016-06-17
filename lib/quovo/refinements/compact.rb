module Quovo
  module Refinements
    module Compact
      refine Hash do
        def compact!
          delete_if { |_, value| value.nil? }
        end
      end
    end
  end
end
