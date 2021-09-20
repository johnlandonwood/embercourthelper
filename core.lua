local version = 0.1
local AceGUI = LibStub("AceGUI-3.0")

EmberCourtHelper = LibStub("AceAddon-3.0"):NewAddon("EmberCourtHelper", "AceConsole-3.0")

-- Options in Interface (NOT the chat command)
local options = {
    name = "EmberCourtHelper",
    handler = EmberCourtHelper,
    type = 'group',
    args = {
        show = {
            name = "Show",
            desc = "Show the UI", -- TODO: Add functionality for /ech show to also close the window if already open. Not a big deal. Global bool variable? Has to be something more elegant than that.
            type = "execute",
            func = function() EmberCourtHelper:CreateWindow() end,
        }
    },
}

-- Called when the addon is loaded
function EmberCourtHelper:OnInitialize()
    LibStub("AceConfig-3.0"):RegisterOptionsTable("EmberCourtHelper", options)
    self.optionsFrame = LibStub("AceConfigDialog-3.0"):AddToBlizOptions("EmberCourtHelper", "EmberCourtHelper")
    self:RegisterChatCommand("EmberCourtHelper", "ChatCommand")
    self:RegisterChatCommand("ech", "ChatCommand")
end

function EmberCourtHelper:ChatCommand(input)
    if not input or input:trim() == "" then
        self:Print("Your options are show or options")
    elseif input == "show" then
        EmberCourtHelper:CreateWindow()
    elseif input == "options" then
        InterfaceOptionsFrame_OpenToCategory(self.optionsFrame)
    end 
end

function EmberCourtHelper:GetIncompleteReps()
    local reps = {}
    for i = 1838, 1853 do -- Faction IDs 1838 through 1853 are Ember Court friend factions
        local factionID = C_CurrencyInfo.GetFactionGrantedByCurrency(i)
        _, _, _, friendName, _, _, friendTextLevel, _, _ = GetFriendshipReputation(factionID)
        if friendTextLevel ~= "Best Friend" then
            reps[friendName] = friendTextLevel
        end
    end
    return reps
end

function EmberCourtHelper:CreateWindow()

    local frame = AceGUI:Create("Frame")
    frame:SetTitle("EmberCourtHelper")
    frame:SetStatusText("Version " .. version)
    frame:SetCallback("OnClose", function(widget) AceGUI:Release(widget) end)
    frame:SetLayout("List")

    local repGroups = AceGUI:Create("TabGroup")
    repGroups:SetTitle("Incomplete Guest Reputations")
    frame:AddChild(repGroups)
    repGroups:SetLayout("Flow")
    repGroups:SetWidth(665)
    repGroups:SetHeight(150)
    
    local strangers = AceGUI:Create("TabGroup")
    strangers:SetTitle("Strangers")
    repGroups:AddChild(strangers)
    strangers:SetRelativeWidth(.21)

    local acquaintances = AceGUI:Create("TabGroup")
    acquaintances:SetTitle("Acquaintances")
    repGroups:AddChild(acquaintances)
    acquaintances:SetRelativeWidth(.21)

    local buddies = AceGUI:Create("TabGroup")
    buddies:SetTitle("Buddies")
    repGroups:AddChild(buddies)
    buddies:SetRelativeWidth(.21)

    local friends = AceGUI:Create("TabGroup")
    friends:SetTitle("Friends")
    repGroups:AddChild(friends)
    friends:SetRelativeWidth(.21)

    local goodfriends = AceGUI:Create("TabGroup")
    goodfriends:SetTitle("Good Friends")
    repGroups:AddChild(goodfriends)
    goodfriends:SetRelativeWidth(.21)


    local incompleteReps = EmberCourtHelper:GetIncompleteReps()
    for name, standing in pairs(incompleteReps) do
        local repLine = AceGUI:Create("Label")
        repLine:SetText(name)
        -- Set image here
        if standing == "Stranger" then
            strangers:AddChild(repLine)
        elseif standing == "Acquaintance" then
            acquaintances:AddChild(repLine)
        elseif standing == "Buddy" then
            buddies:AddChild(repLine)
        elseif standing == "Friend" then
            friends:AddChild(repLine)
        elseif standing == "Good Friend" then
            goodfriends:AddChild(repLine)
        end 
    end


    local slot1_options = {"Sika", "Plague Deviser Marileth", "Choofa", "Cryptkeeper Kassir"}
    local slot2_options = {"Kleia and Pelagos", "Grandmaster Vole", "Droman Aliothe", "Stonehead"}
    local slot3_options = {"Polemarch Adrestes", "Alexandros Mograine", "Hunt-Captain Korayn", "Rendle and Cudgelface"}
    local slot4_options = {"Mikanikos", "Baroness Vashj", "Lady Moonberry", "The Countess"}


    -- Create dropdown frame and add child slot frames to select guests
    local dropdownFrame = AceGUI:Create("TabGroup")
    dropdownFrame:SetTitle("Guest Selection")
    dropdownFrame:SetLayout("Flow")
    frame:AddChild(dropdownFrame)
    dropdownFrame:SetWidth(665)
    dropdownFrame:SetHeight(200)

    local slot1_choice
    local slot1 = AceGUI:Create("Dropdown")
    slot1:SetRelativeWidth(.25)
    slot1:SetLabel("Select 1st Guest")
    slot1:SetList(slot1_options)
    -- slot1:SetValue("Sika") -- Save between sessions
    slot1:SetCallback("OnValueChanged", function(widget, event, choice) slot1_choice = choice end)
    dropdownFrame:AddChild(slot1)

    local slot2_choice
    local slot2 = AceGUI:Create("Dropdown")
    slot2:SetRelativeWidth(.25)
    slot2:SetLabel("Select 2nd Guest")
    slot2:SetList(slot2_options)
    slot2:SetValue("Kleia and Pelagos")
    slot2:SetCallback("OnValueChanged", function(widget, event, choice) slot2_choice = choice end)
    dropdownFrame:AddChild(slot2)

    local slot3_choice
    local slot3 = AceGUI:Create("Dropdown")
    slot3:SetRelativeWidth(.25)
    slot3:SetLabel("Select 3rd Guest")
    slot3:SetList(slot3_options)
    slot3:SetValue("Polemarch Adrestes")
    slot3:SetCallback("OnValueChanged", function(widget, event, choice) slot3_choice = choice end)
    dropdownFrame:AddChild(slot3)

    local slot4_choice
    local slot4 = AceGUI:Create("Dropdown")
    slot4:SetRelativeWidth(.25)
    slot4:SetLabel("Select 4th Guest")
    slot4:SetList(slot4_options)
    slot4:SetValue("Mikanikos")
    slot4:SetCallback("OnValueChanged", function(widget, event, choice) slot4_choice = choice end)
    dropdownFrame:AddChild(slot4)
    
    -- Tables for guest preferences
    local slot1_prefs = {
        {"Clean"}, -- Sika
        {"Messy"}, -- Marileth
        {"Exciting"}, -- Choofa
        {"Formal"} -- Kassir
    }
    local slot2_prefs = {
        {"Humble"}, -- Kleia and Pelagos
        {"Dangerous"}, -- Grandmaster Vole
        {"Relaxing"}, -- Droman Aliothe
        {"Casual"} -- Stonehead
    }
    local slot3_prefs = {
        {"Clean", "Formal"}, -- Polemarch Adrestes
        {"Safe", "Humble"}, -- Alexandros Mograine
        {"Dangerous", "Casual"}, -- Hunt-Captain Korayn 
        {"Messy", "Relaxing"} -- Rendle and Cudgelface
    }
    local slot4_prefs = {
        {"Clean", "Safe", "Humble"}, -- Mikanikos
        {"Dangerous", "Decadent", "Exciting"}, -- Baroness Vashj
        {"Messy", "Exciting", "Casual"}, -- Lady Moonberry
        {"Decadent", "Relaxing", "Formal"} -- The Countess
    }

    -- function to sum each attribute and choose winnner
    -- pass it an attribute name - messy or clean, humble or decadent
    -- sumAttributeWeight("formal")
    -- returns integer for how many times a thing appears
    -- then compare the sum of the two competing attributes
    -- choose the bigger one to display as target attribute.

    -- sum up each time an attribute appears in a guest's preferences matrix.
    -- only if that guest is not at full rank. 
    -- or greater weight to unmaxed guests? 1 for best friend, 2 for non best friend.
    -- whichever attribute out of the two is highest, display that one in the targets. 

    local calc_button = AceGUI:Create("Button")
    calc_button:SetText("Calculate Target Attributes")
    calc_button:SetWidth(300)
    calc_button:SetCallback("OnClick", function() print(slot4_prefs[3][1], slot4_prefs[3][2], slot4_prefs[3][3]) end)
    frame:AddChild(calc_button)
    

end


-- Called when the addon is enabled
function EmberCourtHelper:OnEnable()

end


-- Called when the addon is disabled
function EmberCourtHelper:OnDisable()

end

