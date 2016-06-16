module Quovo
  module Hook
    def hook(&callback)
      hooks << callback
    end

    def hooks
      @@hooks ||= []
    end

    def clear_hooks!
      @@hooks = []
    end

    def run_hooks!(*args)
      hooks.each do |hook|
        hook.call(*(args << Quovo.current_scope))
      end
      :ok
    end
  end
end
