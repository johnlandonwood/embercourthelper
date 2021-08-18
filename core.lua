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
            func = function() EmberCourtHelper:ToggleWindow() end,
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
        EmberCourtHelper:ToggleWindow()
    elseif input == "options" then
        InterfaceOptionsFrame_OpenToCategory(self.optionsFrame)
    end 
end

function EmberCourtHelper:ToggleWindow()
    local frame = AceGUI:Create("Frame")
    frame:SetTitle("EmberCourtHelper")
    frame:SetStatusText("Version " .. version)
    frame:SetCallback("OnClose", function(widget) AceGUI:Release(widget) end)
    frame:SetLayout("Flow")
    
    local repMessage = AceGUI:Create("Label")
    repMessage:SetText("Welcome to EmberCourtHelper.")
    frame:AddChild(repMessage)

end



-- Called when the addon is enabled
function EmberCourtHelper:OnEnable()
    self:Print("Loaded successfully!")
end


-- Called when the addon is disabled
function EmberCourtHelper:OnDisable()

end

