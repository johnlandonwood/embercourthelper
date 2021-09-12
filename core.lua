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

    local welcomeMessage = AceGUI:Create("Label") -- TODO: Change to heading - why does frame go blank?
    welcomeMessage:SetText("Welcome to EmberCourtHelper.")
    frame:AddChild(welcomeMessage)

    local incompleteReps = EmberCourtHelper:GetIncompleteReps()
    for name, standing in pairs(incompleteReps) do
        local repLine = AceGUI:Create("Label")
        repLine:SetText(name .. " - " .. standing)
        -- set image here
        frame:AddChild(repLine)
    end

    local slot1_options = {"Sika", "Plague Deviser Marileth", "Choofa", "Cryptkeeper Kassir"}
    local slot2_options = {"Kleia and Pelagos", "Grandmaster Vole", "Droman Aliothe", "Stonehead"}
    local slot3_options = {"Polemarch Adrestes", "Alexandros Mograine", "Hunt-Captain Korayn", "Rendle and Cudgelface"}
    local slot4_options = {"Mikanikos", "Baroness Vashj", "Lady Moonberry", "The Countess"}

    -- Create dropdown frame and add child slot frames to select guests
    local dropdownFrame = AceGUI:Create("Frame")
    dropdownFrame:SetTitle("Guest Selection")
    dropdownFrame:SetLayout("Flow")
    frame:AddChild(dropdownFrame)
    -- dropdownFrame:ClearAllPoints()
    -- dropdownFrame:SetPoint("RIGHT", frame, "RIGHT")
    -- TODO: Figure out how to anchor dropdownframe to frame so that it can't be dragged & resized by user
    dropdownFrame:SetRelativeWidth(1.0)
    dropdownFrame:SetHeight(200)

    local slot1 = AceGUI:Create("Dropdown")
    slot1:SetRelativeWidth(.25)
    slot1:SetLabel("Select 1st Guest")
    slot1:SetList(slot1_options)
    slot1:SetValue("Sika") -- Save between sessions
    dropdownFrame:AddChild(slot1)

    local slot2 = AceGUI:Create("Dropdown")
    slot2:SetRelativeWidth(.25)
    slot2:SetLabel("Select 2nd Guest")
    slot2:SetList(slot2_options)
    slot2:SetValue("Kleia and Pelagos")
    dropdownFrame:AddChild(slot2)

    local slot3 = AceGUI:Create("Dropdown")
    slot3:SetRelativeWidth(.25)
    slot3:SetLabel("Select 3rd Guest")
    slot3:SetList(slot3_options)
    slot3:SetValue("Polemarch Adrestes")
    dropdownFrame:AddChild(slot3)

    local slot4 = AceGUI:Create("Dropdown")
    slot4:SetRelativeWidth(.25)
    slot4:SetLabel("Select 4th Guest")
    slot4:SetList(slot4_options)
    slot4:SetValue("Mikanikos")
    dropdownFrame:AddChild(slot4)


    -- frame:AddChild(dropdownFrame)
    -- frame:AddChild(slot1)


    
    -- array with 1,2,3,4 spots for selected faction and their attributes

end


-- Called when the addon is enabled
function EmberCourtHelper:OnEnable()
    self:Print("Loaded successfully!")
end


-- Called when the addon is disabled
function EmberCourtHelper:OnDisable()

end

