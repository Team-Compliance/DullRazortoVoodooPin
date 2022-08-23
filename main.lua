YAVPODR = RegisterMod("Dull Razor to Voodoo Pin", 1)
local mod = YAVPODR

local items = {
	{CollectibleType.COLLECTIBLE_DULL_RAZOR, "Voodoo Pin", "Ow!"}
}

VoodooPinWiki = {
	{ -- Effect
		{str = "Effect", fsize = 2, clr = 3, halign = 0},
		{str = "Hurts Isaac without taking away health, activating any items that trigger upon taking damage."},
	},
	{ -- Notes
		{str = "Notes", fsize = 2, clr = 3, halign = 0},
		{str = "As using the Voodoo Pin will grant invincibility frames like normal damage, this item can be used to enter Curse Rooms ([-REP] or use Blood Donation Machines and Devil Beggars) for free."},
	},
	{ -- Interactions
		{str = "Interactions", fsize = 2, clr = 3, halign = 0},
		{str = "- Blanket/ Holy Mantle/ Wooden Cross: Absorbs the 'hit', wasting both items."},
		{str = "-- [REP] Voodoo Pin ignores the shield, giving its normal effect without wasting the shield."},
		{str = "- Bloody Lust/ Bloody Gust: Especially useful, as all of the stat ups are permanent for the floor."},
		{str = "- Car Battery: Voodoo Pin activates twice, but 'damage' is only dealt once, not triggering synergies a second time."},
		{str = "- Cone Head: Can block the 'hit' Voodoo Pin inflicts, causing no effect."},
		{str = "- Crown of Light: Disables Crown of Light for the current room."},
		{str = "- Habit: Doesn't charge Voodoo Pin itself."},
		{str = "-- Habit + Schoolbag: The secondary item will be charged."},
		{str = "- Isaac's Heart: Completely nullifies the effect of Voodoo Pin."},
		{str = "- The Lost/ Tainted Jacob/ Tainted Lost: 'Damage' taken from Voodoo Pin causes no actual harm, allowing full use of the Pin. This is one of the only ways to see the 'hurt' animation from these characters."},
		{str = "-- [REP] A character temporarily turned into The Lost by touching a White Fire Place will die from Voodoo Pin's damage."},
		{str = "- Purity: Will cancel the current effect of Purity, akin to taking regular damage. Useful for if you want to roll for a different, better effect, but can also get rid of the one you want."},
	},
	{ -- Trivia
		{str = "Trivia", fsize = 2, clr = 3, halign = 0},
		{str = "This item used to be Dull Razor but was replaced by Voodoo Pin from Antibirth."},
	},
}

if EID then
	for i,item in ipairs(items) do
		local EIDdescription = EID:getDescriptionObj(5, 100, item[1]).Description
		EID:addCollectible(item[1], EIDdescription, item[2], "en_us")
	end
end

if Encyclopedia then
	for i,item in ipairs(items) do
		Encyclopedia.UpdateItem(item[1], {
			Class = "vanilla",
			Name = item[2],
			Description = item[3],
			WikiDesc = VoodooPinWiki
		})
	end
end

local queueLastFrame
local queueNow
function mod.onUpdate(_, player)
	queueNow = player.QueuedItem.Item
	if (queueNow ~= nil) then	
		for i,item in ipairs(items) do
			if (queueNow.ID == item[1] and queueNow:IsCollectible() and queueLastFrame == nil) then
				Game():GetHUD():ShowItemText(item[2], item[3])
			end
		end
	end
	queueLastFrame = queueNow
end
mod:AddCallback(ModCallbacks.MC_POST_PLAYER_UPDATE, mod.onUpdate)
