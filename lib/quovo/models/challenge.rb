module Quovo
  module Models
    class Challenge < Base
      using Quovo::Refinements::Cast

      fields %i(
        account
        type
        is_answered
        last_asked
        should_answer
        question
        image
        choices
        image_choices
      )

      undef :image
      def image
        @image.cast(Image)
      end

      undef :choices
      def choices
        @choices.cast(Choice)
      end

      undef :image_choices
      def image_choices
        @image_choices.cast(Image)
      end
    end
  end
end
