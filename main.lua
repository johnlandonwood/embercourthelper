-- Register slash command "/embercourthelper" to start the AddOn
SLASH_EMBERCOURTHELPER1 = "/embercourthelper"

--Function executed on slash command call
function EmberCourtHelperCommand(msg)
    print("EmberCourtHelper initiated.")

    -- Initialize frame to display EmberCourtHelper data, buttons, options, etc.
    local ech_frame = CreateFrame("Frame", "EmberCourtHelperFrame", UIParent)
    ech_frame:SetPoint("CENTER")
    ech_frame:SetSize(100, 50)

    ech_frame.texture = ech_frame:CreateTexture(nil, "BACKGROUND")
    ech_frame.texture:SetAllPoints(true)
    ech_frame.texture:SetTexture(1, 1, 1, 0.0)

    local text = ech_frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    text:SetPoint("CENTER")
    text:SetText("Sample Text")
    
    -- Figure out how to make frame template look like in game menu 
    -- List reputations

end

SlashCmdList["EMBERCOURTHELPER"] = EmberCourtHelperCommand;

-- for i = 1838, 1853 do -- Faction IDs 1838 through 1853 are Ember Court friend factions
--     local factionID = C_CurrencyInfo.GetFactionGrantedByCurrency(i)
--     _, _, _, friendName, _, _, friendTextLevel, _, _ = GetFriendshipReputation(factionID)
--     if friendTextLevel ~= "Best Friend" then
--         print(friendName, friendTextLevel)
--     end
-- end

