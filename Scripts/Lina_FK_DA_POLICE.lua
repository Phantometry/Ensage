--<<Lina FK DA POLICE by Phantometry and Nova-chan>>--
require("libs.Utils")
require("libs.ScriptConfig")
require("libs.TargetFind")

config = ScriptConfig.new()
config:SetParameter("ComboKey", "T", config.TYPE_HOTKEY)
config:Load()

local comboKey = config.ComboKey 
local registered = false 
local target = nil 
local active = false
local delay = 0
local Text = {}

function Key(msg,code)
	if client.chat or client.console or client.loading then return end
	if code == comboKey then
		active = (msg == KEY_DOWN)
	end
end

function Main(tick)
	if not SleepCheck() then return end
	local me = entityList:GetMyHero()
	if not me then return end
	
	local Eul = me:FindItem("item_cyclone")
	local Ethereal = me:FindItem("item_ethereal_blade")
	local Q = me:GetAbility(1)
	local W = me:GetAbility(2)
	local R = me:GetAbility(4)
	local dagon = me:FindDagon()
	
	local Enemies = entityList:GetEntities({type=LuaEntity.TYPE_HERO,illusion=false,team=me:GetEnemyTeam()})
	for i,v in ipairs(Enemies) do
	    local OnScreen = client:ScreenPosition(v.position)
		Damage = DamageCalculation(v)
		if OnScreen then
		    if v.healthbarOffset ~= -1 then
			        if not Text[v.handle] then
						Font = drawMgr:CreateFont("F14","Segoe UI",14,550)
						Text[v.handle] = drawMgr:CreateText(25,-55, 0x00FFFFAA, "HP to Kill: ",Font) 
						Text[v.handle].visible = false
						Text[v.handle].entity = v 
						Text[v.handle].entityPosition = Vector(-130,-30,v.healthbarOffset)
					end
					if v.health - Damage < 0 then
						Text[v.handle].text = "Kill this mofo!"
						Text[v.handle].color = 0xFF0000FF
					elseif active then
					    Text[v.handle].text = "Combo-ing!"
					else
						Text[v.handle].text = "HP left: "..math.ceil(v.health - Damage)
						Text[v.handle].color = 0xFFFF00FF
					end
					if (v.visible and v.alive) and Text [v.handle].visible ~= true then
						Text [v.handle].visible = true 
					elseif (not v.visible or not v.alive) and Text [v.handle].visible == true then
						Text [v.handle].visible = false
				    end
			end
		end
	end
	
    target = targetFind:GetClosestToMouse(100)
	
	if active and target then
	   local EulModif = target:FindModifier("modifier_eul_cyclone")
	   local EtherealModif = target:FindModifier("modifier_item_ethereal_blade_slow")
	   local distance = me:GetDistance2D(target) 
	   
	    if distance > 625 then
		   delay = (distance-625)/me.movespeed
		else 
		   delay = 0
        end		   
	
		if Eul and Eul:CanBeCasted() then 
			me:CastAbility(Eul,target)
            Sleep(500)			
		end	   		
		
		if EulModif and EulModif.remainingTime < 0.9+delay and EulModif.remainingTime > 0.5  then
			me:CastAbility(W,target.position) 
			Sleep(200) 
			return
		elseif not Ethereal and EulModif and EulModif.remainingTime < 0.5 then
		    me:CastAbility(Q,target,position)
			Sleep(200)
		elseif not Eul:CanBeCasted() and not EulModif then
			if Ethereal and Ethereal:CanBeCasted() and not EtherealModif then
			    me:CastAbility(Ethereal,target)
				Sleep(200)
			elseif EtherealModif then
			    me:CastAbility(Q,target)
				if dagon and dagon:CanBeCasted() then
				    me:CastAbility(dagon,target,true)
	            end
				me:CastAbility(R,target,true)
				Sleep(500)
			elseif not Ethereal then
				if dagon and dagon:CanBeCasted() then
				    me:CastAbility(dagon,target,true)
	            end
				me:CastAbility(R,target,true)
				Sleep(500)
            end		
		end
	end
end

function DamageCalculation(Enemy)
    local me = entityList:GetMyHero()
    local Ethereal = me:FindItem("item_ethereal_blade")
	local Aghanims = me:FindItem("item_ultimate_scepter")
	local Q = me:GetAbility(1)
	local W = me:GetAbility(2)
	local R = me:GetAbility(4)
	local dagon = me:FindDagon()
	local QDmg = {110,180,250,320}
	local WDmg = {120,160,200,240}
	local RDmg = {450,675,950}
	local DmgQ = 0
	local DmgR = 0
	local DmgD = 0
	local Dmg = 0
	local EReady = false
	
	if W and W:CanBeCasted() and W.level > 0 then 
	    Dmg = Dmg + Enemy:DamageTaken(WDmg[W.level],DAMAGE_MAGC,me)
    end
	if Ethereal and Ethereal:CanBeCasted() then
	    EReady = true
	    Dmg = Dmg + Enemy:DamageTaken((2 * me.intellectTotal + 75),DAMAGE_MAGC,me) 
	end
	if Q and Q:CanBeCasted() and Q.level > 0 then 
	    DmgQ = Enemy:DamageTaken(QDmg[Q.level],DAMAGE_MAGC,me)
        if EReady then 
		    DmgQ = DmgQ*1.4
		end
		Dmg = DmgQ + Dmg
    end
	if R and R:CanBeCasted() and R.level > 0 and not Aghanims then
	    DmgR = Enemy:DamageTaken(RDmg[R.level],DAMAGE_MAGC,me)
        if EReady then 
		    DmgR = Dmg*1.4
		end
		Dmg = DmgR + Dmg
	elseif R and R:CanBeCasted() and R.level > 0 and Aghanims then
	    Dmg = Dmg + Enemy:DamageTaken(RDmg[R.level],DAMAGE_PURE,me)
	end
	if dagon and dagon:CanBeCasted() then 
	   DmgD = Enemy:DamageTaken((dagon:GetSpecialData("damage")),DAMAGE_MAGC,me)
        if EReady then 
		    DmgD = DmgD*1.4
		end
		Dmg = DmgD + Dmg
	end
	return Dmg
end
	
	
function onLoad()
	if PlayingGame() then
		local me = entityList:GetMyHero()
		if not me or me.classId ~= CDOTA_Unit_Hero_Lina then
			script:Disable()
		else
			registered = true
			script:RegisterEvent(EVENT_TICK,Main)
			script:RegisterEvent(EVENT_KEY,Key)
			script:UnregisterEvent(onLoad)
		end
	end
end

function onClose()
	collectgarbage("collect")
	if registered then
		script:UnregisterEvent(Main)
		script:UnregisterEvent(Key)
		script:RegisterEvent(EVENT_TICK,onLoad)
		registered = false
	end
end

script:RegisterEvent(EVENT_CLOSE,onClose)
script:RegisterEvent(EVENT_TICK,onLoad)
