function init()
  effect.setParentDirectives("fade="..config.getParameter("color").."=0.5")
  script.setUpdateDelta(0)
end

function update(dt)

end

function uninit()
  if not self.exploded then
    local sourceEntityId = effect.sourceEntity() or entity.id()
    local sourceDamageTeam = world.entityDamageTeam(sourceEntityId)
    local bombPower = status.resourceMax("health") * config.getParameter("healthDamageFactor", 1.0)
    local projectileConfig = {
      power = bombPower,
      --damageTeam = sourceDamageTeam,
      onlyHitTerrain = true,
      timeToLive = 0,
      actionOnReap = {
        {
          action = "config",
          file = config.getParameter("bombConfig")
        }
      }
    }
    world.spawnProjectile("invisibleprojectile", mcontroller.position(), 0, {0, 0}, false, projectileConfig)
    self.exploded = true
  end
end
