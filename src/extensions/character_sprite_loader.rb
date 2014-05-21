require 'yaml'

class CharacterSpriteLoader

  SPRITE_WIDTH = 64
  SPRITE_HEIGHT = 64

  ANIMATIONS_CONFIG_FILE = 'src/config/character_animations.yml'

  attr_reader :animations

  def initialize(sprite_sheet_file)
    @sprite_sheet_file = sprite_sheet_file
  end

  def load
    @animations_config = YAML.load_file(ANIMATIONS_CONFIG_FILE)
    load_sprite_sheet
    load_animations
  end


  private

  def load_sprite_sheet
    texture = Texture.new(Gdx.files.internal(@sprite_sheet_file))
    @texture_region = TextureRegion.split(texture, SPRITE_WIDTH, SPRITE_HEIGHT)
  end


  def load_animations
    @animations = {}

    @animations_config.each do |action_name, config|

      action = "CharacterAction::#{action_name.upcase}".constantize
      @animations[action] ||= {}

      config['directions'].each do |direction_name, direction_values|
        direction = "Direction::#{direction_name.upcase}".constantize
        @animations[action][direction] = load_animation(config['speed'],
                                                        direction_values['frames'],
                                                        config['play_mode'])
      end
    end
  end

  # Internal: Loads a single animation.
  #
  # animation_speed    - The Float time between frames in seconds.
  # frames_coordinates - The coordinates of the images.
  # play_mode          - The type of animation.
  #
  # Returns an Animation.
  def load_animation(animation_speed, frames_coordinates, play_mode)
    animation_frames = []

    frames_coordinates.each_with_index do |coordinates, index|
      animation_frames[index] = @texture_region[coordinates[0]][coordinates[1]]
    end

    animation = Animation.new(animation_speed, animation_frames.to_java(TextureRegion))
    animation.set_play_mode("Animation::#{play_mode.upcase}".constantize)
    animation
  end
end
