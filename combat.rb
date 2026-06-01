module Combat
  def self.attack_roll(attacker)
    attacker.str + rand(1..6)
  end

  def self.defence_roll(attacker)
    attacker.dex + rand(1..6)
  end
  def self.resolve_attack(attacker, defender)
    potential_damage = attack_roll(attacker)
    defence_score = defence_roll(attacker)
    hit_chance = rand(100)

    if defence_score < defender.dex
      # defender wins the defence roll
      if hit_chance < 10
        # 10% chance full damage happens
        apply_damage(defender, potential_damage)
        :hit
      elsif hit_chance < 55
        # 45% chance of half damage
        apply_damage(defender, potential_damage / 2)
        :partial
      else
        # 45% chance to miss dealing no damage
        :miss
      end
    else
      # attacker wins the defence roll
      if hit_chance < 90
        # 90% chance full damage occurs
        apply_damage(defender, potential_damage)
        :hit
      elsif hit_chance < 95
        # 5% chance half damage occurs
        apply_damage(defender, potential_damage / 2)
        :partial
      else
        # 5% chance to miss entirely
        :miss
      end
    end
  end
  def self.apply_damage(defender, damage)
    defender.hp -= damage
    defender.hp = 0 if defender.hp < 0
  end

  def self.dead?(entity)
    entity.hp <= 0
  end
end