module Quovo
  module Api
    class Challenges < Base
      using Quovo::Refinements::Cast
      using Quovo::Refinements::Require

      def for_account(id)
        id.require!(as: :id)
        api(:get, "/accounts/#{id}/challenges")
          .fetch('challenges')
          .cast(Challenge)
      end

      def answers!(account_id, answers)
        account_id.require!(as: 'account_id')
        answers.require!(as: 'answers')
        answers.each do |answer|
          answer.require!(:answer, :question)
        end

        params = { questions: answers.to_json }
        api(:put, "/accounts/#{account_id}/challenges", params)
          .fetch('challenges')
          .cast(Challenge)
      end
    end
  end
end
