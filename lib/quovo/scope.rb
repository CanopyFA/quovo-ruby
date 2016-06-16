module Quovo
  module Scope
    def scope(attributes)
      parent = current_scope
      set_current_scope(current_scope.merge(attributes))
      result = yield if block_given?
      set_current_scope(parent)
      result
    end

    def current_scope
      Thread.current[:__quovo_scope__] ||= {}
    end

    def set_current_scope(scope)
      Thread.current[:__quovo_scope__] = scope
    end
  end
end
