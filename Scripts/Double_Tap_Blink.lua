--<<Double-Tap Blink by Phantometry and Nova-chan v 0.3>>--

require("libs.Utils")
require("libs.ScriptConfig")

config = ScriptConfig.new()
config:SetParameter("BlinkKey", "W", config.TYPE_HOTKEY)
config:Load()

local ComboKey = config.BlinkKey
local active = false 
local registered = false 
local pressedonce = false
local blinkpos = nil
local keyup = false

function Load()
    local me = entityList:GetMyHero()
	
	if PlayingGame() then
	    if (me.classId ~= CDOTA_Unit_Hero_AntiMage) and (me.classId ~= CDOTA_Unit_Hero_QueenOfPain) then 
			script:Disable()
		else
		    registered = true 
			script:RegisterEvent(EVENT_TICK,Tick)
			script:UnregisterEvent(Load)
		end
	end
end


function Close()
	collectgarbage("collect")
	if registered then
		script:UnregisterEvent(Tick)
		script:UnregisterEvent(Key)
		script:RegisterEvent(EVENT_TICK,Load)
        active = false 
        registered = false 
        pressedonce = false
        blinkpos = nil
        keyup = false
	end
end

	
function Tick(tick)
    if not SleepCheck() then return end
	if client.chat then return end 
	
    local me = entityList:GetMyHero()
    if not me then return end
	if blinkpos == nil then
	    if me.team == 2 then 
	       blinkpos = Vector(-7149,-6696,383)
	    else 
	       blinkpos = Vector(7149,6696,383)
	    end
	end
	
	
    local Ability1 = me:GetAbility(2)
	
    if IsKeyDown(ComboKey) and not pressedonce then 
      pressedonce = true
	  Sleep(500,"Cancel")
	  Sleep(50)
	end
	
	if pressedonce and not IsKeyDown(ComboKey) then
		keyup = true 
	end
	
	if pressedonce and keyup and IsKeyDown(ComboKey) then 
	    me:CastAbility(Ability1,blinkpos)
	elseif pressedonce and SleepCheck("Cancel") then
	    pressedonce = false 
		keyup = false 
	end
	
	Sleep(Ability1.cd)
	
end

script:RegisterEvent(EVENT_CLOSE,Close)
script:RegisterEvent(EVENT_TICK,Load)
