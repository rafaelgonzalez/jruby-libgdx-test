require 'json'

class FooGameSaveCreator

  def initialize(foo_game)
    @game = foo_game
    @dungeon_level = @game.instance_variable_get('@dungeon_level')
    @dungeon_level_characters = @dungeon_level.instance_variable_get('@level_characters')
  end

  def save!
    save_output = JSON.pretty_generate(save_hash)
    File.open('./save.json', 'w') { |file| file.write(save_output) }
  end

  private

  def save_hash
    {
      dungeon_level_characters: dungeon_level_characters_hash
    }
  end

  def dungeon_level_characters_hash
    @dungeon_level_characters.collect do |level_character|
      {
        character: {
          current_action: level_character.instance_variable_get('@character').current_action,
          current_direction: level_character.instance_variable_get('@character').current_direction
        },
        current_tile: {
          x_position: level_character.current_tile.x_position,
          y_position: level_character.current_tile.y_position
        },
        destination_tile: {
          x_position: level_character.destination_tile.x_position,
          y_position: level_character.destination_tile.y_position
        }
      }
    end
  end
end