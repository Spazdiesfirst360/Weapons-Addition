require "/scripts/util.lua"
require "/items/active/weapons/weapon.lua"

AssaultMelee = WeaponAbility:new()

function AssaultMelee:init()
  self.cooldownTimer = self.cooldownTime
end

function AssaultMelee:update(dt, fireMode, shiftHeld)
  WeaponAbility.update(self, dt, fireMode, shiftHeld)

  self.cooldownTimer = math.max(0, self.cooldownTimer - dt)

  if self.weapon.currentAbility == nil and self.fireMode == "alt" and self.cooldownTimer == 0 and status.overConsumeResource("energy", self.energyUsage) then
    self:setState(self.windup)
  end
end

function AssaultMelee:windup()
  self.weapon:setStance(self.stances.windup)
  self.weapon:updateAim()

  util.wait(self.stances.windup.duration)

  self:setState(self.fire)
end

function AssaultMelee:fire()
  self.weapon:setStance(self.stances.fire)
  self.weapon:updateAim()

  local position = vec2.add(mcontroller.position(), {self.projectileOffset[1] * mcontroller.facingDirection(), self.projectileOffset[2]})
  local params = {
    powerMultiplier = activeItem.ownerPowerMultiplier(),
    power = self:damageAmount()
  }
  world.spawnProjectile(self.projectileType, position, activeItem.ownerEntityId(), self:aimVector(), false, params)

  animator.playSound(self:slashSound())

  util.wait(self.stances.fire.duration)
  self.cooldownTimer = self.cooldownTime
end

function AssaultMelee:slashSound()
  return self.weapon.elementalType.."TravelSlash"
end

function AssaultMelee:aimVector()
  return {mcontroller.facingDirection(), 0}
end

function AssaultMelee:damageAmount()
  return self.baseDamage * config.getParameter("damageLevelMultiplier")
end

function AssaultMelee:uninit()
end
