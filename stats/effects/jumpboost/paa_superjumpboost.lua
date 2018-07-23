function init()
  local bounds = mcontroller.boundBox()
  effect.addStatModifierGroup({
    {stat = "jumpModifier", amount = 20.0}
  })
end

function update(dt)
  mcontroller.controlModifiers({
      airJumpModifier = 7.0
    })
end

function uninit()
  
end
