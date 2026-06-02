# handles all of the keyboard input.
require_relative 'combat'

module InputHandler

  def self.handle(id, player, npcs, map, hud)
    if id == Gosu::KB_RIGHT
      player.face_right
      npc = Combat.check_for_enemy_on_target_tile(npcs, player.x + 1, player.y)
      if npc
        result = Combat.perform_attack(player, npc)
        hud.add_message(hud.combat_message(npc, result))
        npcs.reject! { |n| Combat.dead?(n) }
      elsif map.detect_collision(player.x + 1, player.y)
        player.move_right
      end
      npcs.each do |npc|
        result = npc.move_toward(player, map, npcs)
        if result == :hit or result == :partial or result == :miss
          hud.add_message(hud.npc_attack_message(npc, result))
        end
      end
    elsif id == Gosu::KB_LEFT
      player.face_left
      npc = Combat.check_for_enemy_on_target_tile(npcs, player.x - 1, player.y)
      if npc
        result = Combat.perform_attack(player, npc)
        hud.add_message(hud.combat_message(npc, result))
        npcs.reject! { |n| Combat.dead?(n) }
      elsif map.detect_collision(player.x - 1, player.y)
        player.move_left
      end
      npcs.each do |npc|
        result = npc.move_toward(player, map, npcs)
        if result == :hit or result == :partial or result == :miss
          hud.add_message(hud.npc_attack_message(npc, result))
        end
      end
    elsif id == Gosu::KB_UP
      player.face_up
      npc = Combat.check_for_enemy_on_target_tile(npcs, player.x, player.y - 1)
      if npc
        result = Combat.perform_attack(player, npc)
        hud.add_message(hud.combat_message(npc, result))
        npcs.reject! { |n| Combat.dead?(n) }
      elsif map.detect_collision(player.x, player.y - 1)
        player.move_up
      end
      npcs.each do |npc|
        result = npc.move_toward(player, map, npcs)
        if result == :hit or result == :partial or result == :miss
          hud.add_message(hud.npc_attack_message(npc, result))
        end
      end
    elsif id == Gosu::KB_DOWN
      player.face_down
      npc = Combat.check_for_enemy_on_target_tile(npcs, player.x, player.y + 1)
      if npc
        result = Combat.perform_attack(player, npc)
        hud.add_message(hud.combat_message(npc, result))
        npcs.reject! { |n| Combat.dead?(n) }
      elsif map.detect_collision(player.x, player.y + 1)
        player.move_down
      end
      npcs.each do |npc|
        result = npc.move_toward(player, map, npcs)
        if result == :hit or result == :partial or result == :miss
          hud.add_message(hud.npc_attack_message(npc, result))
        end
      end
    end
  end

end