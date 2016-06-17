module Quovo
  module Refinements
    module Cast
      refine Object do
        def cast(model)
          case self
          when Hash
            model.new(self)
          when Array
            map do |entry|
              entry.cast(model)
            end
          when NilClass
            nil
          else
            raise 'unknown source type for casting'
          end
        end
      end
    end
  end
end
