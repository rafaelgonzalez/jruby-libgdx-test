require 'dungeon_crawl_stage'

class FooGame < Game
  include Input

  def create
    @dungeon_crawl_stage = DungeonCrawlStage.new

    # @dungeon_level = Dungeon::Level.new
    # @dungeon_level.spawn_character!(Character.new, 1, 1)

    dungeon_level_character = DungeonLevelCharacterActor.new(1, 1)
    @dungeon_crawl_stage.add_actor(dungeon_level_character)
    @dungeon_crawl_stage.set_keyboard_focus(dungeon_level_character)

    @font = BitmapFont.new
    @screen_text = SpriteBatch.new
  end

  def render
    Gdx.app.exit if is_key_pressed?(Keys::ESCAPE)

    Gdx.gl.glClear(GL10::GL_COLOR_BUFFER_BIT | GL10::GL_DEPTH_BUFFER_BIT)

    @dungeon_crawl_stage.act(Gdx.graphics.get_delta_time)
    @dungeon_crawl_stage.draw

    render_fps

    # @dungeon_level.level_characters.each {|character| character.transform_from_input! }
    # 
    # @dungeon_level.draw(@state_time, @camera)
  end

  def resize(width, height)
    @dungeon_crawl_stage.set_viewport(width, height, true)
  end

  def pause
  end

  def resume
  end

  def dispose
    @dungeon_crawl_stage.dispose
    # save_game_state!
  end


  private

  def is_key_pressed?(key)
    Gdx.input.is_key_pressed(key)
  end

  def render_fps
    @screen_text.begin
    @font.draw(@screen_text, "#{Gdx.graphics.get_frames_per_second} FPS", 10, Gdx.graphics.get_height - 10)
    @screen_text.end
  end

  # def load_game_state!
  #   FooGameSaveLoader.new(self).load!
  # end
  # 
  # def save_game_state!
  #   FooGameSaveCreator.new(self).save!
  # end
end