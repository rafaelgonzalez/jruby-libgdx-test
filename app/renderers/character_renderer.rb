class CharacterRenderer
  SPRITE_WIDTH = 64
  SPRITE_HEIGHT = 64

  def initialize
    @sprite_sheet_loader = SpriteSheetLoader.new("data/light.png", 64, 64)

    @walk_animation = @sprite_sheet_loader.animation(11, (0..8))

    @sprite_batch = SpriteBatch.new
  end

  def draw(state_time, sprite_x_pos, sprite_y_pos)
    @sprite_batch.begin
    @sprite_batch.draw(current_frame(state_time), sprite_x_pos, sprite_y_pos)
    @sprite_batch.end
  end

  private
  def current_frame(state_time)
    @walk_animation.get_key_frame(state_time, true)
  end
end