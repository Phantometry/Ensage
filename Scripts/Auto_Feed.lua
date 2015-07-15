--<<Auto_Feed by Phantometry>>--
require("libs.Utils")

local registered = false
local Move = false
local MovePosition = nil

function Load()
  local me = entityList:GetMyHero()

  if PlayingGame() then
    registered = true
    script:RegisterEvent(EVENT_TICK,Tick)
    script:UnregisterEvent(Load)
  end
end

function Tick(tick)
  if client.paused then return end

  local me = entityList:GetMyHero()
  if not me then return end
  if MovePosition == nil then
    if me.team == 2 then
      MovePosition = Vector(7149,6696,383)
    else
      MovePosition = Vector(-7149,-6696,383)
    end
  end

  if not Move then
    Move = true
  end

  if Move then
    me:Move(MovePosition)
  end

end

function Close()
  collectgarbage("collect")
  if registered then
    script:UnregisterEvent(Tick)
    script:RegisterEvent(EVENT_TICK,Load)
    registered = false
    Move = false
    MovePosition = nil
  end
end

script:RegisterEvent(EVENT_CLOSE,Close)
script:RegisterEvent(EVENT_TICK,Load)
