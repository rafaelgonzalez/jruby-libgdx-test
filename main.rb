require 'initializer'

cfg = LwjglApplicationConfiguration.new
cfg.title = "FooGame"
cfg.useGL20 = true
cfg.width = 800
cfg.height = 640
LwjglApplication.new(FooGame.new, cfg)