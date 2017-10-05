module Quovo
  module Utils
    module Cast
      def cast(object, model)
        Quovo::Utils::Cast.cast(object, model)
      end

      def self.cast(object, model)
        case object
        when Hash
          model.new(object)
        when Array
          map {|entry| cast(entry, model)}
        when NilClass
          nil
        else
          raise 'unknown source type for casting'
        end
      end
    end
  end
end
