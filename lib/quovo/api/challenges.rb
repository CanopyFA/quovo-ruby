module Quovo
  module Api
    class Challenges < Base
      include Quovo::Utils::Cast
      include Quovo::Utils::Require

      def for_account(id)
        require!(id, as: :id)
        cast(api(:get, "/accounts/#{id}/challenges").fetch('challenges'), Challenge)
      end

      def answers!(account_id, answers)
        require!(account_id, as: 'account_id')
        require!(answers, as: 'answers')
        answers.each do |answer|
          require!(answer, :answer, :question)
        end

        params = { questions: answers.to_json }
        cast(api(:put, "/accounts/#{account_id}/challenges", params).fetch('challenges'), Challenge)
      end

      def find(challenge_id)
        challenge_id.require!(as: 'challenge_id')
        api(:get, "/challenges/#{challenge_id}")
          .fetch('challenge')
          .cast(Challenge)
      end

      def answer!(challenge_id, answer)
        challenge_id.require!(as: 'challenge_id')
        answer.require!(as: 'answer')

        params = { answer: answer.to_json }
        api(:put, "/challenges/#{challenge_id}", params)
          .fetch('challenge')
          .cast(Challenge)
      end
    end
  end
end
