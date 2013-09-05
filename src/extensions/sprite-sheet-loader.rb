class SpriteSheetLoader
  def initialize(sheet_file_path, sprite_width, sprite_height)
    @texture = Texture.new(Gdx.files.internal(sheet_file_path))
    @texture_region = TextureRegion.split(@texture, sprite_width, sprite_height)
  end

  def animation(y_position, x_range, animation_speed = 0.15)
    animation_frames = @texture_region[y_position][x_range]
    Animation.new(animation_speed, animation_frames)
  end
end