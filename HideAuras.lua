-- Hides auras on arena frames, nameplates, and raid frames

local function hideFrameElementPermanently(frameElement)
    if frameElement then
        frameElement:Hide()
        frameElement:SetScript("OnShow", frameElement.Hide)
    end
end

local function hideArenaFrameElements()
    for arenaFrameIndex = 1, 5 do
        local compactArenaFrame = _G["CompactArenaFrameMember" .. arenaFrameIndex]
        if compactArenaFrame then
            hideFrameElementPermanently(compactArenaFrame.name)
            hideFrameElementPermanently(compactArenaFrame.DebuffFrame)
            hideFrameElementPermanently(compactArenaFrame.castBar)
        end
    end
end

local function hideNameplateBuffFrames(nameplateUnitToken)
    local nameplateFrame = C_NamePlate.GetNamePlateForUnit(nameplateUnitToken)
    if not nameplateFrame then return end
    
    local nameplateUnitFrame = nameplateFrame.UnitFrame
    if not nameplateUnitFrame or nameplateUnitFrame:IsForbidden() then return end

    local nameplateBuffFrame = nameplateUnitFrame.BuffFrame
    if not nameplateBuffFrame then return end

    if not nameplateBuffFrame._cleanFramesHook then
        nameplateBuffFrame._cleanFramesHook = true
        nameplateBuffFrame:HookScript("OnShow", function(buffFrame)
            buffFrame:Hide()
        end)
    end
    
    nameplateBuffFrame:Hide()
end

local function hideRaidFrameBuffsAndDebuffs(raidFrame)
    if not raidFrame or raidFrame:IsForbidden() then 
        return 
    end

    if CompactUnitFrame_HideAllBuffs then
        CompactUnitFrame_HideAllBuffs(raidFrame)
    end

    if CompactUnitFrame_HideAllDebuffs then
        CompactUnitFrame_HideAllDebuffs(raidFrame)
    end
end

local arenaAndNameplateEventFrame = CreateFrame("Frame")
arenaAndNameplateEventFrame:RegisterEvent("ARENA_OPPONENT_UPDATE")
arenaAndNameplateEventFrame:RegisterEvent("NAME_PLATE_UNIT_ADDED")
arenaAndNameplateEventFrame:SetScript("OnEvent", function(_, registeredEventName, nameplateUnitToken)
    if registeredEventName == "ARENA_OPPONENT_UPDATE" then
        hideArenaFrameElements()
    elseif registeredEventName == "NAME_PLATE_UNIT_ADDED" then
        hideNameplateBuffFrames(nameplateUnitToken)
    end
end)

hooksecurefunc("CompactUnitFrame_UpdateAuras", hideRaidFrameBuffsAndDebuffs)
