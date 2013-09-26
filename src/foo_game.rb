class FooGame < Game
  include Input

  def create
    @camera = OrthographicCameraExtended.new
    @camera.set_to_ortho(false)
    @character = Character.new
    @dungeon_level = DungeonLevel.new
    @state_time = 0.0
  end

  def render
    Gdx.app.exit if is_key_pressed?(Keys::ESCAPE)

    Gdx.gl.glClear(GL10::GL_COLOR_BUFFER_BIT | GL10::GL_DEPTH_BUFFER_BIT)
    @state_time = @state_time + Gdx.graphics.get_delta_time

    @character.transform_from_input!
    @camera.transform_from_input!

    @dungeon_level.draw(@camera)
    @character.draw(@state_time, @camera)
  end

  def resize(width, height)
  end

  def pause
  end

  def resume
  end

  def dispose
  end


  private

  def is_key_pressed?(key)
    Gdx.input.is_key_pressed(key)
  end
end