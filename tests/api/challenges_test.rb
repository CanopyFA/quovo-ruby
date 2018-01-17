require 'init'
class TestApiChallenges < TestApi
  def test_challenges_for_account
    id = 1
    expected = [simple_challenge(id)]
    fake(:get, "/accounts/#{id}/challenges", {}, 'challenges' => expected)

    actual = Quovo.challenges.for_account(id)
    assert_equal(actual.length, 1)
    assert_type(actual, Quovo::Models::Challenge)
    assert_content(expected, actual)
  end

  def test_challenges_answers!
    id       = 1
    answers  = [{ question: 'What is your favourite color?', answer: 'cyan' }]
    params   = { questions: answers.to_json }
    expected = [simple_challenge(id)]
    fake(:put, "/accounts/#{id}/challenges", params, 'challenges' => expected)

    actual = Quovo.challenges.answers!(id, answers)
    assert_equal(actual.length, 1)
    assert_type(actual, Quovo::Models::Challenge)
    assert_content(expected, actual)
  end

  def test_find_challenge
    id = 1
    expected = simple_challenge(id)
    fake(:get, "/challenges/#{id}", {}, 'challenge' => expected)

    actual = Quovo.challenges.find(id)
    assert_type([actual], Quovo::Models::Challenge)
    assert_content([expected], [actual])
  end

  def test_challenge_answer!
    id       = 1
    answer   = { question: 'What is your favourite color?', answer: 'cyan' }
    params   = { answer: answer.to_json }
    expected = simple_challenge(id)
    fake(:put, "/challenges/#{id}", params, 'challenge' => expected)

    actual = Quovo.challenges.answer!(id, answer)
    assert_type([actual], Quovo::Models::Challenge)
    assert_content([expected], [actual])
  end

  # helpers
  def challenge(*args)
    instance(Quovo::Models::Challenge, *args)
  end

  def simple_challenge(i)
    challenge(i, 'question', false, false, true, 'What is your favourite color?', nil, nil, nil)
  end
end
