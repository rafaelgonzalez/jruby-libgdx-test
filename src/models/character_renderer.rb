module CharacterRenderer

  CHARACTER_MOVEMENT_SPEED = 100
  CHARACTER_GROUND_OFFSET = 25

  attr_accessor :screen_x_position, :screen_y_position

  # Public: Initializes the necessary variables in the Character instance for rendering.
  #
  # Returns nothing.
  def initialize_rendering
    @screen_x_position = 0
    @screen_y_position = 0
    load_animations
  end

  # Public: Render the character sprite on screen.
  #
  # Returns nothing.
  def draw(state_time, camera)
    @sprite_batch.set_projection_matrix(camera.combined)
    @sprite_batch.begin
    @sprite_batch.draw(current_frame(state_time), @screen_x_position, @screen_y_position)
    @sprite_batch.end
  end

  def sprite_width
    LpcSpriteSheetLoader::SPRITE_WIDTH
  end

  def sprite_height
    LpcSpriteSheetLoader::SPRITE_HEIGHT
  end

  private

  # Internal: Get the current animation according the the Character's state.
  #
  # Returns an Animation.
  def current_animation
    @animations[@current_action][@current_direction]
  end

  # Internal: Get the current frame of the Character's current animation.
  #
  # Returns a TextureRegion.
  def current_frame(state_time)
    current_animation.get_key_frame(state_time, true)
  end


  private

  # Internal: Loads the character animations.
  #
  # Returns nothing.
  def load_animations
    @animations = LpcSpriteSheetLoader.animations_from_sprite_sheet_file("assets/light.png")
    @sprite_batch = SpriteBatch.new
  end
end