module Quovo
  module Models
    class Challenge < Base
      include Quovo::Utils::Cast

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
        cast(@image, Image)
      end

      undef :choices
      def choices
        cast(@choices, Choice)
      end

      undef :image_choices
      def image_choices
        cast(@image_choices, Image)
      end
    end
  end
end
