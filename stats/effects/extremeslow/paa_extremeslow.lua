function init()
  animator.setParticleEmitterOffsetRegion("drips", mcontroller.boundBox())
  animator.setParticleEmitterActive("drips", true)
  effect.setParentDirectives("fade=D1CC87=0.1")
  effect.addStatModifierGroup({
    {stat = "jumpModifier", amount = -0.75}
  })
end

function update(dt)
  mcontroller.controlModifiers({
      speedModifier = 0.2,
      airJumpModifier = 0.2
    })
end

function uninit()

end
