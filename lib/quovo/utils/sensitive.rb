module Quovo
  module Utils
    module Sensitive
      FILTER_KEYS = %w(username password question answer access_token choices questions).freeze
      def self.strip_sensitive(object)
        case object
        when Hash
          {}.tap do |result|
            object.each do |key, value|
              result[key] = FILTER_KEYS.include?(key.to_s) ? '[FILTERED]' : strip_sensitive(value)
            end
          end
        when Array
          block = -> (value) { strip_sensitive(value) }
          object.map(&block)
        else
          object
        end
      end

      def self.sensitive?(object)
        case object
        when Hash
          object.each do |key, value|
            return true if FILTER_KEYS.include?(key.to_s) || sensitive?(value)
          end
        when Array
          object.each do |value|
            return true if sensitive?(value)
          end
        end
        false
      end
    end
  end
end
