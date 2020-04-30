module Quovo
  module Utils
    module ToTime
      def to_time(object)
        Quovo::Utils::ToTime.to_time(object)
      end

      def self.to_time(object)
        case object
        when String
          Time.parse(object + ' UTC')
        when NilClass
          nil
        else
          raise "cannot convert #{object.inspect} to time"
        end
      end
    end
  end
end
