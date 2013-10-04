class FooGame < Game
  include Input

  def create
    @characters = [Character.new]
    @dungeon_level = Dungeon::Level.new
    @dungeon_level.spawn_character!(@characters.first, 1, 1)

    load_game_state!

    @state_time = 0.0
    @camera = OrthographicCameraExtended.new
    @camera.set_to_ortho(false)

    @font = BitmapFont.new
    @screen_text = SpriteBatch.new
  end

  def render
    Gdx.app.exit if is_key_pressed?(Keys::ESCAPE)

    Gdx.gl.glClear(GL10::GL_COLOR_BUFFER_BIT | GL10::GL_DEPTH_BUFFER_BIT)

    render_fps

    @state_time = @state_time + Gdx.graphics.get_delta_time

    @dungeon_level.level_characters.each {|character| character.transform_from_input! }

    @camera.transform_from_input!

    @dungeon_level.draw(@state_time, @camera)
  end

  def resize(width, height)
  end

  def pause
  end

  def resume
  end

  def dispose
    save_game_state!
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

  def load_game_state!
    FooGameSaveLoader.new(self).load!
  end

  def save_game_state!
    FooGameSaveCreator.new(self).save!
  end
end