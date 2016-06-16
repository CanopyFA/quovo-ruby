module Quovo
  module Models
    class Challenge < Base
      using Quovo::Refinements::Cast

      fields %i[
        account
        type
        is_answered
        last_asked
        should_answer
        question
        image
        choices
        image_choices
      ]

      def image
        @image.cast(Image)
      end

      def choices
        @choices.cast(Choice)
      end

      def image_choices
        @image_choices.cast(Image)
      end
    end
  end
end
