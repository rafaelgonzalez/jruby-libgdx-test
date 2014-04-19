class DungeonCrawlInterface
  class CharacterDetails
    class ProgressBarWithLabel < ProgressBar

      attr_reader :label

      def initialize(min, max, stepSize, vertical, skin)
        super(min, max, stepSize, vertical, skin)

        @label = Label.new('', skin)
      end

      def draw(sprite_batch, alpha)
        super(sprite_batch, alpha)

        label.set_text(" #{self.get_value.to_i} / #{self.get_max_value.to_i}")
      end
    end
  end
end
