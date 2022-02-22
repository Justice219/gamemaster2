AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
AddCSLuaFile("base/thirdparty/imgui.lua")

include("shared.lua")

gm = gm or {}
gm.server = gm.server or {}
gm.server.db = gm.server.db or {}
gm.server.chat = gm.server.chat or {}
gm.server.net = gm.server.net or {}
gm.server.errors = gm.server.errors or {}
gm.server.main = gm.server.main or {}

gm.server.data = gm.server.data or {}
gm.server.data.main = gm.server.data.main or {}

function ENT:Initialize()

    -- Setup ent basics
    self:SetModel("models/lt_c/sci_fi/holo_tablet.mdl")
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)
    self:SetUseType(SIMPLE_USE)
    self:SetSkin(1)

    -- Set Values n shit
    local tbl = {
        ["name"] = "Kyber Map",
        ["desc"] = "Location on a planet that contains Kyber crystals.",
        ["text"] = "Kyber Crystal Map \n You can use slash n to make a new line in the file",
    }
    self:SetDataTable(util.TableToJSON(tbl))

    local phys = self:GetPhysicsObject()
    if phys:IsValid() then
        phys:Wake()
    end

end

function ENT:Use(act, caller)
    net.Start("GM2:Entities:Datapad:Open")
    net.WriteTable(gm.server.data.main)
    net.WriteEntity(self)
    net.Send(caller)
end

function ENT:SetData(tbl)
    self:SetDataTable(util.TableToJSON(tbl))
end