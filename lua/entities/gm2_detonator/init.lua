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
    self:SetModel("models/props/starwars/weapons/detpack.mdl")
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)
    self:SetUseType(SIMPLE_USE)
    self:SetSkin(1)

    self:SetIsExploding(false)
    self:SetBeenPlaced(false)
    self:SetExplosionTime(10)


    local phys = self:GetPhysicsObject()
    if phys:IsValid() then
        phys:Wake()
    end

end

function ENT:Use(act, caller)
    if !self:GetBeenPlaced() then
        self:SetBeenPlaced(true)

        self:SetMaterial("")
    else
        if !self:GetIsExploding() then
            self:Explode()
            act:JLIBChatNotify("Detonator", "Detpack has been activated!")
        end
    end
end

function ENT:ExplodeEffect()
    local effectdata = EffectData()
    effectdata:SetOrigin(self:GetPos())
    effectdata:SetScale(1)
    effectdata:SetMagnitude(1)
    util.Effect("Explosion", effectdata)
end

function ENT:Explode()
    timer.Create("gm2_detonator_".. self:EntIndex(), self:GetExplosionTime(), 1, function()
        for k,v in pairs(constraint.FindConstraints(self, "Weld")) do
            print(v)
        end
        self:Remove()
        if IsValid(self:GetParentProp()) then
            self:GetParentProp():Remove()
        end
        self:ExplodeEffect()
    end)
    self:SetIsExploding(true)
end

function ENT:Delete()
    if self:GetIsExploding() then
        timer.Remove("gm2_detonator_".. self:EntIndex())
    end
    self:Remove()
end

function ENT:Think()
    if self:GetIsExploding() then
        self:SetTimeLeft(timer.TimeLeft("gm2_detonator_" .. self:EntIndex()))
    end
end

function ENT:SetData(time, prop)
    self:SetExplosionTime(time)
    self:SetParentProp(prop)
end