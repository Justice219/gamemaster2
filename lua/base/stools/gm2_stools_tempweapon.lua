gm = gm or {}
gm.server = gm.server or {}
gm.server.data = gm.server.data or {}
gm.server.data.tempweapon = gm.server.data.tempweapon or {}

hook.Add("PlayerSpawn", "gm2_tempweapon", function(ply)
    gm.server.data.tempweapon[ply:SteamID()] = gm.server.data.tempweapon[ply:SteamID()] or {}
    for k,v in pairs(gm.server.data.tempweapon[ply:SteamID()]) do
        ply:Give(k)
    end
end)