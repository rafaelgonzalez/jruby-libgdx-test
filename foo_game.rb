class FooGame < Game
  include Input

  def create
  end

  def render
    Gdx.app.exit if is_key_pressed?(Keys::ESCAPE)
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
    Gdx.input.isKeyPressed(key)
  end
end