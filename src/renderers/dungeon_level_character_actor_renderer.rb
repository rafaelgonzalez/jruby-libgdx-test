module DungeonLevelCharacterActorRenderer
  CHARACTER_MOVEMENT_SPEED = 100
  CHARACTER_GROUND_OFFSET = 25

  attr_accessor :screen_x_position, :screen_y_position

  # Public: Initializes the necessary variables in the Character instance for rendering.
  #
  # Returns nothing.
  def initialize_rendering
    load_animations
  end

  # Public: Render the DungeonLevelCharacterActor's sprite on screen.
  # Overrides Actor#draw.
  #
  # Returns nothing.
  def draw(sprite_batch, alpha)
    color = get_color
    sprite_batch.set_color(color.r, color.g, color.b, color.a * alpha)
    sprite_batch.draw(current_animation_frame,
                      get_x,
                      get_y,
                      get_origin_x,
                      get_origin_y,
                      get_width,
                      get_height,
                      get_scale_x,
                      get_scale_y,
                      get_rotation)
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
    @animations[current_action][current_direction]
  end

  # Internal: Get the current frame of the Character's current animation.
  #
  # Returns a TextureRegion.
  def current_animation_frame
    current_animation.get_key_frame(@state_time)
  end


  private

  # Internal: Loads the character animations.
  #
  # Returns nothing.
  def load_animations
    @animations = LpcSpriteSheetLoader.animations_from_sprite_sheet_file("assets/light.png")
  end
end
