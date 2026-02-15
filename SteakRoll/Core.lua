local f = CreateFrame("Frame")

local function OnEvent(self, event, ...)
	if event == "START_LOOT_ROLL" then
		local rollID = ...
		local _, _, _, quality, bop, canNeed, canGreed, canDE = GetLootRollItemInfo(rollID)

		if quality == 2 then
			if canDE then
				RollOnLoot(rollID, 3)
			else
				RollOnLoot(rollID, 2)
			end
		elseif quality == 3 or quality == 4 then
			if not canNeed then
				if bop and canDE then
					RollOnLoot(rollID, 3)
				else
					RollOnLoot(rollID, 2)
				end
			end
		end
	elseif event == "CONFIRM_LOOT_ROLL" or event == "CONFIRM_DISENCHANT_ROLL" then
		local rollID, rollType = ...

		ConfirmLootRoll(rollID, rollType)
		StaticPopup_Hide("CONFIRM_LOOT_ROLL")
		StaticPopup_Hide("CONFIRM_DISENCHANT_ROLL")
	end
end

f:RegisterEvent("START_LOOT_ROLL")
f:RegisterEvent("CONFIRM_LOOT_ROLL")
f:RegisterEvent("CONFIRM_DISENCHANT_ROLL")

f:SetScript("OnEvent", OnEvent)
