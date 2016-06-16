module Quovo
  module Fake
    def fake?
      @fake
    end

    # format of fake calls
    # [
    #   [:get, "/accounts/id", {}, { id: 123, nickname: '123' ... }]
    # ]
    def fake!(fake_calls = [])
      @fake_calls = fake_calls
      @fake = true
      Quovo.config.token_storage = Object.new.tap do |o|
        def o.read(key)
          ['FAKE-TOKEN', (Time.now.utc + 1_000).iso8601].join('|')
        end
      end
    end

    def real!
      @fake = false
    end


    def fake_calls
      @fake_calls
    end
  end
end
