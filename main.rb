require 'initializer'

cfg = LwjglApplicationConfiguration.new
cfg.title = "FooGame"
cfg.width = 800
cfg.height = 640
LwjglApplication.new(YetAnotherDungeonCrawler.new, cfg)
