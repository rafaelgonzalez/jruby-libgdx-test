class SpriteSheetLoader
  def initialize(sheet_file_path, sprite_width, sprite_height)
    @texture = Texture.new(Gdx.files.internal(sheet_file_path))
    @texture_region = TextureRegion.split(@texture, sprite_width, sprite_height)
  end

  def animation(y_position, x_range, animation_speed, play_mode)
    animation_frames = @texture_region[y_position][x_range]
    animation = Animation.new(animation_speed, animation_frames)
    animation.set_play_mode(play_mode)
    animation
  end
end