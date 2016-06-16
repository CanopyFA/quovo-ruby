module Quovo
  module Refinements
    module Permit
      refine Hash do
        def permit!(*keys)
          self.delete_if {|k, _| !keys.include?(k)}
        end
      end
    end
  end
end