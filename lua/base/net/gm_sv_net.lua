gm = gm or {}
gm.server = gm.server or {}
gm.server.tools = gm.server.tools or {}
gm.server.errors = gm.server.errors or {}
gm.server.net = gm.server.net or {}

gm.server.data = gm.server.data or {}
gm.server.data.tools = gm.server.data.tools or {}

gm.server.data.main = gm.server.data.main or {}

net.Receive("GM2:Tools:Run", function(len, ply)
    local r = gm.server.data.main.ranks
    local pr = ply:GetUserGroup()

    if ply:GetUserGroup() == "Founder" or ply:GetUserGroup() == "founder" or ply:GetUserGroup() == "superadmin" or r[pr] then 
        gm.server.tools.run(net.ReadString(), ply, net.ReadTable())
    end
end)
net.Receive("GM2:Net:PanelAccess", function(len, ply)
    local r = gm.server.data.main.ranks
    local pr = ply:GetUserGroup()

    if ply:GetUserGroup() == "Founder" or ply:GetUserGroup() == "founder" or ply:GetUserGroup() == "superadmin" or r[pr] then
        local rank= net.ReadTable()
        PrintTable(rank)

        for k,v in pairs(rank) do
            if v == true then
                gm.server.main.addRank(k)
            else
                gm.server.main.removeRank(k)
            end
        end
    end
end)
net.Receive("GM2:Entities:WeaponGiver:Verify", function(len, ply)
    local ent = net.ReadEntity()
    local r = gm.server.data.main.ranks
    local pr = ply:GetUserGroup()

    if ply:GetUserGroup() == "Founder" or ply:GetUserGroup() == "founder" or ply:GetUserGroup() == "superadmin" or r[pr] then
        net.Start("GM2:Entities:WeaponGiver:Open")
        net.WriteEntity(ent)
        net.Send(ply)
    end
end)
net.Receive("GM2:Entities:ModelGiver:Verify", function(len, ply)
    local ent = net.ReadEntity()
    local r = gm.server.data.main.ranks
    local pr = ply:GetUserGroup()

    if ply:GetUserGroup() == "Founder" or ply:GetUserGroup() == "founder" or ply:GetUserGroup() == "superadmin" or r[pr] then
        net.Start("GM2:Entities:ModelGiver:Open")
        net.WriteEntity(ent)
        net.Send(ply)
    end
end)
net.Receive("GM2:Entities:WeaponGiver:Set", function(len, ply)
    local ent = net.ReadEntity()
    local wep = net.ReadString()
    local quan = net.ReadInt(32)

    local r = gm.server.data.main.ranks
    local pr = ply:GetUserGroup()

    if ply:GetUserGroup() == "Founder" or ply:GetUserGroup() == "founder" or ply:GetUserGroup() == "superadmin" or r[pr] then
        ent:SetData(wep, quan)
    end
end)
net.Receive("GM2:Entities:ModelGiver:Set", function(len, ply)
    local ent = net.ReadEntity()
    local str = net.ReadString()
    local name = net.ReadString()

    local r = gm.server.data.main.ranks
    local pr = ply:GetUserGroup()

    if ply:GetUserGroup() == "Founder" or ply:GetUserGroup() == "founder" or ply:GetUserGroup() == "superadmin" or r[pr] then
        ent:SetData(str,name)
    end
end)

net.Receive("GM2:Entities:Datapad:Set", function(len, ply)
    local r = gm.server.data.main.ranks
    local pr = ply:GetUserGroup()
    local ent = net.ReadEntity()

    if ply:GetUserGroup() == "Founder" or ply:GetUserGroup() == "founder" or ply:GetUserGroup() == "superadmin" or r[pr] then
        ent:SetData(net.ReadTable())
    end
end)