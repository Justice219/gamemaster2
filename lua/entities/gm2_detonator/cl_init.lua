-- Incoludes
include("shared.lua")
local imgui = include("base/thirdparty/imgui.lua")

-- Data stuff 
gm = gm or {}
gm.client = gm.client or {}
gm.client.menus = gm.client.menus or {}

gm.client.data = gm.client.data or {}
gm.client.data.main = gm.client.data.main or {}
gm.client.data.main.ranks = gm.client.data.main.ranks or {}

function ENT:Draw()
    self:DrawModel()
    
    if imgui.Entity3D2D(self, Vector(-15,-6,15), Angle(0,-90,90), 0.1) then
        -- Main UI
        if !self:GetBeenPlaced() then
            draw.RoundedBox(6, -185,-1, 250, 90, Color(58,58,58, 100))
            draw.SimpleText("Detonator", imgui.xFont("!Roboto@20"),-180, -0, Color(255,255,255)) 
            draw.SimpleText("Press E To Place", imgui.xFont("!Roboto@20"),-180, 20, Color(255,255,255)) 
        elseif !self:GetIsExploding() then
            draw.RoundedBox(6, -185,-1, 250, 90, Color(58,58,58, 100))
            draw.SimpleText("Detonator (Armed)", imgui.xFont("!Roboto@20"),-180, -0, Color(255,136,0)) 
            draw.SimpleText("Press E To Activate", imgui.xFont("!Roboto@20"),-180, 20, Color(255,255,255)) 
        elseif self:GetIsExploding() then
            draw.RoundedBox(6, -185,-1, 250, 90, Color(58,58,58, 100))
            draw.SimpleText("Detonator (Exploding)", imgui.xFont("!Roboto@20"),-180, -0, Color(255,136,0))
            draw.SimpleText("Time Left: " .. self:GetTimeLeft(), imgui.xFont("!Roboto@20"),-180, 20, Color(255,255,255))
        end

        imgui.End3D2D()
    end
end
