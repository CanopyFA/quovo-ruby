module Quovo
  module Models
    class Base
      extend ::Forwardable
      def_delegators :to_h, :fetch, :to_json

      def self.fields(fields = nil)
        if fields
          @fields = fields.map(&:to_sym)
          @fields.each do |field|
            attr_reader field
          end
        else
          @fields || []
        end
      end

      def initialize(props)
        props.each do |field, value|
          instance_variable_set("@#{field}", value)
        end
      end

      def [](field)
        send(field)
      end

      def to_hash
        self.class.fields.map do |field|
          [field, self[field]]
        end.to_h
      end

      def to_h
        to_hash
      end
    end
  end
end
