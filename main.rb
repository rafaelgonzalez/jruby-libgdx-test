require 'java'
require 'lib/java/gdx-backend-lwjgl-natives.jar'
require 'lib/java/gdx-backend-lwjgl.jar'
require 'lib/java/gdx-natives.jar'
require 'lib/java/gdx.jar'

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

java_import com.badlogic.gdx.backends.lwjgl.LwjglApplication
java_import com.badlogic.gdx.backends.lwjgl.LwjglApplicationConfiguration

$CLASSPATH << 'src'
$CLASSPATH << 'src/extensions'
$CLASSPATH << 'src/renderers'

require 'foo_game'
require 'sprite-sheet-loader.rb'
require 'character_renderer.rb'

cfg = LwjglApplicationConfiguration.new
cfg.title = "FooGame"
cfg.useGL20 = true
cfg.width = 800
cfg.height = 640
LwjglApplication.new(FooGame.new, cfg)