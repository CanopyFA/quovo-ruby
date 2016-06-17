module Quovo
  module Hook
    def hook(&callback)
      hooks << callback
    end

    def hooks
      @hooks ||= []
    end

    def clear_hooks!
      @hooks = []
    end

    def run_hooks!(*args)
      log_params = (args << Quovo.current_scope)
      hooks.each do |hook|
        hook.call(*log_params)
      end
      :ok
    end
  end
end
