class CombatLogger

  MESSAGES_LIMIT = 10
  LINE_HEIGHT = 20
  ANCHOR_POSITION = 50
  LEFT_OFFSET = 250

  attr_reader :messages

  def initialize
    @messages = []

    @font = BitmapFont.new
    @screen_text = SpriteBatch.new
  end

  def add_message(text)
    remove_oldest_message if reached_messages_limit?
    @messages.unshift(text)
  end

  def draw
    @screen_text.begin

    @messages.each_with_index do |message, index|
      @font.draw(@screen_text, message, Gdx.graphics.get_width - LEFT_OFFSET, message_line_height(index+1))
    end

    @screen_text.end
  end

  private

  def remove_oldest_message
    @messages.pop
  end

  def reached_messages_limit?
    @messages.size >= MESSAGES_LIMIT
  end

  def message_line_height(line_number)
    ANCHOR_POSITION + (LINE_HEIGHT * line_number)
  end
end
