require 'json'
require 'active_support/core_ext/hash/indifferent_access'

class FooGameSaveLoader

  def initialize(foo_game)
    @game = foo_game
    load_save_file
  end

  def load!
    return false unless @save_hash

    dungeon_level = Dungeon::Level.new
    characters = []

    @save_hash[:dungeon_level_characters].each do |level_character|
      character = Character.new
      character.instance_variable_set('@current_direction', level_character[:character][:current_direction])
      character.instance_variable_set('@current_action', level_character[:character][:current_action])
      characters << character

      dungeon_level.spawn_character!(
        character,
        level_character[:current_tile][:x_position],
        level_character[:current_tile][:y_position]
      )
    end

    @game.instance_variable_set('@characters', characters)
    @game.instance_variable_set('@dungeon_level', dungeon_level)
  end

  private

  def load_save_file
    if File.exists?('./save.json')
      serialized_save = File.read('./save.json')
      @save_hash = JSON.parse(serialized_save).with_indifferent_access
    else
      @save_hash = nil
    end
  end
end