require 'java'
require 'lib/java/libgdx-nightly-20130916/gdx-backend-lwjgl-natives.jar'
require 'lib/java/libgdx-nightly-20130916/gdx-backend-lwjgl.jar'
require 'lib/java/libgdx-nightly-20130916/gdx-natives.jar'
require 'lib/java/libgdx-nightly-20130916/gdx.jar'

java_import com.badlogic.gdx.ApplicationListener
java_import com.badlogic.gdx.Game
java_import com.badlogic.gdx.Gdx
java_import com.badlogic.gdx.Input
java_import com.badlogic.gdx.graphics.GL10
java_import com.badlogic.gdx.graphics.Texture
java_import com.badlogic.gdx.graphics.OrthographicCamera
java_import com.badlogic.gdx.graphics.g2d.Animation
java_import com.badlogic.gdx.graphics.g2d.BitmapFont
java_import com.badlogic.gdx.graphics.g2d.SpriteBatch
java_import com.badlogic.gdx.graphics.g2d.TextureRegion

java_import com.badlogic.gdx.scenes.scene2d.Actor
java_import com.badlogic.gdx.scenes.scene2d.InputListener
java_import com.badlogic.gdx.scenes.scene2d.Stage
java_import com.badlogic.gdx.scenes.scene2d.actions.Actions
java_import com.badlogic.gdx.scenes.scene2d.actions.MoveToAction
java_import com.badlogic.gdx.scenes.scene2d.actions.RunnableAction

java_import com.badlogic.gdx.maps.tiled.TmxMapLoader
java_import com.badlogic.gdx.maps.tiled.renderers.OrthogonalTiledMapRenderer

java_import com.badlogic.gdx.backends.lwjgl.LwjglApplication
java_import com.badlogic.gdx.backends.lwjgl.LwjglApplicationConfiguration

dir = File.expand_path(File.join(File.dirname(__FILE__), 'src'))
$LOAD_PATH << dir

%w{ constants extensions models actions actors cameras input_listeners renderers stages}.each do |dir|
  path = File.expand_path(File.join(File.dirname(__FILE__), 'src', dir))
  $LOAD_PATH << path
end

begin
  require 'pry'
rescue LoadError
end

require 'foo_game'
require 'foo_game_save_creator'
require 'foo_game_save_loader'

require 'dungeon/level'
require 'dungeon/level/tile'

require 'character_action'
require 'sprite_sheet_loader'
require 'lpc_sprite_sheet_loader'

require 'key_bindings/camera'