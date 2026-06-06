module Combat
  def self.attack_roll(attacker)
    attacker.str + rand(1..6)
  end

  def self.defence_roll(attacker)
    attacker.dex + rand(1..6)
  end

  # check if there is an enemy on the target tile before attacking
  def self.check_for_enemy_on_target_tile(npcs, x, y)
    found = nil
    i = 0
    while i < npcs.length
      if npcs[i].x == x && npcs[i].y == y
        found = npcs[i]
      end
      i += 1
    end
    found
  end
  

  # check for any npcs adjacent to the player and trigger opportunity attacks
  # the dummy never gets an opportunity attack
  def self.opportunity_attacks(player, npcs, hud, enemy_sound)
    i = 0
    while i < npcs.length
      npc = npcs[i]
      dx = (npc.x - player.x).abs
      dy = (npc.y - player.y).abs
      if dx + dy == 1 && npc.type != 'dummy'
        result = perform_attack(npc, player)
        hud.add_message(hud.npc_attack_message(npc, result))
        enemy_sound.play
      end
      i += 1
    end
  end

  # roll  a six sided die and reduce damage by defence stat if roll is 4 or higher
  def self.armour_roll(defender, damage)
    roll = rand(1..6)
    if roll >= 4
      reduced = damage - defender.defence
      if reduced < 1
        return 1
      end
      return reduced
    end
    damage
  end

  def self.perform_attack(attacker, defender)
    potential_damage = attack_roll(attacker)
    defence_score = defence_roll(attacker)
    hit_chance = rand(100)

    if defence_score < defender.dex
      # defender wins the defence roll
      if hit_chance < 10
        # 10% chance full damage happens
        apply_damage(defender, armour_roll(defender, potential_damage))
        'hit'
      elsif hit_chance < 55
        # 45% chance of half damage
        apply_damage(defender, armour_roll(defender, potential_damage / 2))
        'partial'
      else
        # 45% chance to miss dealing no damage
        'miss'
      end
    else
      # attacker wins the defence roll
      if hit_chance < 90
        # 90% chance full damage occurs
        apply_damage(defender, armour_roll(defender, potential_damage))
        'hit'
      elsif hit_chance < 95
        # 5% chance half damage occurs
        apply_damage(defender, armour_roll(defender, potential_damage / 2))
        'partial'
      else
        # 5% chance to miss entirely
        'miss'
      end
    end
  end

  # apply damage to the defender and set the hit timer for the red flash
  def self.apply_damage(defender, damage)
    defender.hp -= damage
    if defender.hp < 0
      defender.hp = 0
    end
    defender.hit_timer = 8
  end

  def self.dead?(entity)
    entity.hp <= 0
  end
end