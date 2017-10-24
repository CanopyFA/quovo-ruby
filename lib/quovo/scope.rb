module Quovo
  module Scope
    def scope(attributes)
      parent = current_scope
      current_scope(current_scope.merge(attributes))
      result = yield if block_given?
      current_scope(parent)
      result
    end

    def scope_hash
      defined?(RequestStore) ? RequestStore.store : Thread.current
    end

    def current_scope(*args)
      if args.any?
        scope_hash[:__quovo_scope__] = args.first
      else
        scope_hash[:__quovo_scope__] ||= {}
      end
    end
  end
end
