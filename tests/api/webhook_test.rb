require 'init'
class TestApiWebhooks < TestApi
  def test_webhooks_all
    list = [
      simple_webhook(1),
      simple_webhook(2, events: ['account']),
      simple_webhook(3, events: ['portfolios'])
    ]
    fake(:get, '/webhooks', {}, 'webhooks' => list)

    webhooks = Quovo.webhooks.all
    assert_equal(webhooks.length, 3)
    assert_type(webhooks, Quovo::Models::Webhook)
    assert_content(list, webhooks)
  end

  def test_webhooks_create
    params = { events: ['*'], is_active: true, secret: 'secret', name: 'webhook-1', url: 'https://webhook.example.com' }
    expected = simple_webhook(1)
    fake(:post, '/webhooks', params, 'webhook' => expected)

    actual = Quovo.webhooks.create(params)
    assert_type([actual], Quovo::Models::Webhook)
    assert_content([expected], [actual])
  end

  def test_webhooks_update
    params = { events: ['*'], is_active: true, secret: 'secret', name: 'webhook-1', url: 'https://webhook.example.com' }
    expected = simple_webhook(1)
    fake(:put, '/webhooks', params, 'webhook' => expected)

    actual = Quovo.webhooks.update('webhook-1', params)
    assert_type([actual], Quovo::Models::Webhook)
    assert_content([expected], [actual])
  end

  def test_webhooks_delete
    fake(:delete, '/webhooks', { name: 'webhook-1' }, nil)

    nothing = Quovo.webhooks.delete('webhook-1')
    assert_equal({}, nothing)
  end

  # helpers
  def webhook(*args)
    instance(Quovo::Models::Webhook, *args)
  end

  def simple_webhook(i, events: ['*'])
    webhook(events, true, 'secret', "webhook-#{i}", 'https://webhook.example.com')
  end
end
