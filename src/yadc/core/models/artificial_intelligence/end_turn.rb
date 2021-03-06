module Yadc
  module Core
    module ArtificialIntelligence
      class EndTurn

        attr_accessor :dungeon_level, :elapsed_time

        def initialize(dungeon_level)
          @dungeon_level = dungeon_level
          @elapsed_time = 0
        end

        def execute(delta_time = nil)
          if delta_time
            @elapsed_time = elapsed_time + delta_time

            if elapsed_time > 5.0
              dungeon_level.dungeon.end_current_playing_team_turn!
              @elapsed_time = 0
            end
          else
            dungeon_level.dungeon.end_current_playing_team_turn!
          end
        end
      end
    end
  end
end
