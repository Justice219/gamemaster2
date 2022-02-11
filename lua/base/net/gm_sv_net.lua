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