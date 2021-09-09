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

    -- local dropdownFrame = AceGUI:Create("Frame")
    
    local welcomeMessage = AceGUI:Create("Label")
    welcomeMessage:SetText("Welcome to EmberCourtHelper.\n\n")
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

    local dropdownFrame = AceGUI:Create("SimpleGroup")
    dropdownFrame:SetTitle("Guest Selection")
    -- dropdownFrame:SetPoint("CENTER", frame)
    -- dropdownFrame:SetRelativeWidth(.9)
    -- dropdownFrame:SetHeight(100)
    dropdownFrame:setLayout("Flow")
    frame:AddChild(dropdownFrame)

    -- move slots to be defined before dropdown frame is added
    local slot1 = AceGUI:Create("Dropdown")
    slot1:SetLabel("Select 1st Guest")
    slot1:SetList(slot1_options)
    slot1:SetValue(slot1_options[1])
    local slot2 = AceGUI:Create("Dropdown")
    slot2:SetLabel("Select 2nd Guest")
    slot2:SetList(slot2_options)
    slot2:SetValue(slot2_options[1])
    dropdownFrame:addChild(slot1)
    dropdownFrame:addChild(slot2)

    
    
    -- array with 1,2,3,4 spots for selected faction and their attributes

end


-- Called when the addon is enabled
function EmberCourtHelper:OnEnable()
    self:Print("Loaded successfully!")
end


-- Called when the addon is disabled
function EmberCourtHelper:OnDisable()

end

