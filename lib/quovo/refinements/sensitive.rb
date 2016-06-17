module Quovo
  module Refinements
    module Sensitive
      FILTER_KEYS = %w(username password question answer access_token choices questions).freeze
      refine Object do
        def strip_sensitive
          case self
          when Hash
            {}.tap do |result|
              each do |key, value|
                result[key] = FILTER_KEYS.include?(key.to_s) ? '[FILTERED]' : value.strip_sensitive
              end
            end
          when Array
            block = -> (value) { value.strip_sensitive }
            map(&block)
          else
            self
          end
        end

        def sensitive?
          case self
          when Hash
            each do |key, value|
              return true if FILTER_KEYS.include?(key.to_s) || value.sensitive?
            end
          when Array
            each do |value|
              return true if value.sensitive?
            end
          end
          false
        end
      end
    end
  end
end
