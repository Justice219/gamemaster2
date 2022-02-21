AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
AddCSLuaFile("base/thirdparty/imgui.lua")

include("shared.lua")

function ENT:Initialize()

    -- Setup ent basics
    self:SetModel("models/lordtrilobite/starwars/props/kyber_crate_phys.mdl")
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)
    self:SetUseType(SIMPLE_USE)
    self:SetSkin(1)

    -- Set Values n shit
    self:SetWeaponP("rw_sw_dc17")
    self:SetIsEmpty(false)
    self:SetWeaponQuantity(1)

    local phys = self:GetPhysicsObject()
    if phys:IsValid() then
        phys:Wake()
    end

end

function ENT:GiveWeapon(ply)
    ply:Give(self:GetWeaponP())
end

function ENT:Use(act, caller)
    if !self:GetIsEmpty() then
        if !act:HasWeapon(self:GetWeaponP()) then
            self:SetWeaponQuantity(self:GetWeaponQuantity() - 1)
            caller:Give(self:GetWeaponP())
            caller:JLIBChatNotify("Weapon Crate", "You have received a " .. self:GetWeaponP())
            if self:GetWeaponQuantity() <= 0 then
                self:SetIsEmpty(true)
            end
        else
            caller:JLIBChatNotify("Weapon Crate", "You already have this weapon")
        end
    else
        act:JLIBChatNotify("Weapon Crate", "This crate is empty.")
    end

end

function ENT:SetData(wep, qty)
    self:SetWeaponP(wep)
    self:SetWeaponQuantity(qty)
    if qty >= 1 then
        self:SetIsEmpty(false)
    else
        self:SetIsEmpty(true)
    end
end