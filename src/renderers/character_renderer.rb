module CharacterRenderer
  SPRITE_WIDTH = 64
  SPRITE_HEIGHT = 64

  # Public: Loads the character animations.
  #
  # Returns nothing.
  def load_animations
    @sprite_sheet_loader = SpriteSheetLoader.new("assets/light.png", 64, 64)

    @walk_animations = {}
    @walk_animations[Direction::UP] = @sprite_sheet_loader.animation(8, (0..8))
    @walk_animations[Direction::LEFT] = @sprite_sheet_loader.animation(9, (0..8))
    @walk_animations[Direction::DOWN] = @sprite_sheet_loader.animation(10, (0..8))
    @walk_animations[Direction::RIGHT] = @sprite_sheet_loader.animation(11, (0..8))

    @sprite_batch = SpriteBatch.new
  end

  # Public: Render the character sprite on screen.
  #
  # Returns nothing.
  def draw(state_time, sprite_x_pos, sprite_y_pos)
    @sprite_batch.begin
    @sprite_batch.draw(current_frame(state_time), sprite_x_pos, sprite_y_pos)
    @sprite_batch.end
  end


  private

  # Internal: Get the current animation according the the Character's state.
  #
  # Returns an Animation.
  def current_animation
    @walk_animations[@current_direction]
  end

  # Internal: Get the current frame of the Character's current animation.
  #
  # Returns a TextureRegion.
  def current_frame(state_time)
    current_animation.get_key_frame(state_time, true)
  end
end