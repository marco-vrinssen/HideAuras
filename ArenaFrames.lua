-- Customizes arena frame elements for better visibility

local function hideElement(element)
	if element then
		element:Hide()
		element:SetScript("OnShow", element.Hide)
	end
end

local function customizeArenaFrame()
	for arenaIndex = 1, 5 do
		local arenaFrame = _G["CompactArenaFrameMember" .. arenaIndex]
		if arenaFrame then

			-- Hide name
			hideElement(arenaFrame.name)

			-- Position and resize debuff frame
			local debuffs = arenaFrame.DebuffFrame
			if debuffs then
				debuffs:ClearAllPoints()
				debuffs:SetSize(28, 28)
				debuffs:SetPoint("BOTTOMLEFT", arenaFrame, "BOTTOMLEFT", -2, 2)
			end

			-- Position and resize CC remover frame
			local ccRemover = arenaFrame.CcRemoverFrame
			if ccRemover then
				ccRemover:ClearAllPoints()
				ccRemover:SetSize(28, 28)
				ccRemover:SetPoint("TOPLEFT", arenaFrame, "TOPRIGHT", -2, 0)

				-- Zoom CC remover icon
				if ccRemover.Icon then
					ccRemover.Icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
				end
			end

			-- Customize casting bar
			local castBar = arenaFrame.CastingBarFrame
			if castBar then
				hideElement(castBar.Text)
				hideElement(castBar.TextBorder)
				hideElement(castBar.Icon)

				castBar:ClearAllPoints()
				castBar:SetPoint("BOTTOMRIGHT", arenaFrame, "BOTTOMLEFT")
			end

		end
	end
end

local arenaEventFrame = CreateFrame("Frame")
arenaEventFrame:RegisterEvent("ARENA_OPPONENT_UPDATE")
arenaEventFrame:SetScript("OnEvent", customizeArenaFrame)
