module Quovo
  module Refinements
    module Sensitive
      FILTER_KEYS = %w(username password question answer access_token choices questions)
      refine Object do
        def strip_sensitive
          case self
          when Hash
            {}.tap do |result|
              self.each do |key, value|
                result[key] = FILTER_KEYS.include?(key.to_s) ? '[FILTERED]' : value.strip_sensitive
              end
            end
          when Array
            self.map do |value|
              value.strip_sensitive
            end
          else
            self
          end
        end

        def sensitive?
          case self
          when Hash
            self.each do |key, value|
              return true if FILTER_KEYS.include?(key.to_s) || value.sensitive?
            end
          when Array
            self.each do |value|
              return true if value.sensitive?
            end
          end
          false
        end
      end
    end
  end
end
