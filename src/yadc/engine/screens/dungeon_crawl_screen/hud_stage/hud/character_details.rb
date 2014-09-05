class YetAnotherDungeonCrawler < Game
  class DungeonCrawlScreen < ScreenAdapter
    class HudStage < Stage
      class Hud < Table
        class CharacterDetails

          attr_reader :name, :health_bar, :mana_bar, :stamina_bar, :action_points_bar, :table

          def initialize(skin)

            @table = Table.new

            @name = Label.new('', skin)

            @health_bar = ProgressBarWithLabel.new(0, 0, 1, false, skin)
            @stamina_bar = ProgressBarWithLabel.new(0, 0, 1, false, skin)
            @mana_bar = ProgressBarWithLabel.new(0, 0, 1, false, skin)
            @action_points_bar = ProgressBarWithLabel.new(0, 0, 1, false, skin)

            table.add(name).colspan(2)

            table.row

            table.add(health_bar)
            table.add(health_bar.label)

            table.row

            table.add(stamina_bar)
            table.add(stamina_bar.label)

            table.row

            table.add(mana_bar)
            table.add(mana_bar.label)

            table.row

            table.add(action_points_bar)
            table.add(action_points_bar.label)
          end

          def set_with_character(character)
            name.set_text(character.name)

            health_bar.set_range(0, character.maximum_health)
            health_bar.set_value(character.health)

            stamina_bar.set_range(0, character.maximum_stamina)
            stamina_bar.set_value(character.stamina)

            mana_bar.set_range(0, character.maximum_mana)
            mana_bar.set_value(character.mana)

            action_points_bar.set_range(0, character.maximum_action_points)
            action_points_bar.set_value(character.action_points)
          end
        end
      end
    end
  end
end
