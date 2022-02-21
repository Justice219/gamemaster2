gm = gm or {}
gm.server = gm.server or {}
gm.server.db = gm.server.db or {}

gm.server.db.create("gm2_permamodel", {
    [1] = {
        name = "model_tbl",
        type = "TEXT",
    }
})
hook.Remove("PlayerSpawn", "gm2_permamodel")
hook.Add("PlayerSpawn", "gm2_permamodel", function(ply)
    timer.Simple(0.1, function()
        local val = gm.server.db.loadAll("gm2_permamodel", "model_tbl")
        if val then
            tbl = util.JSONToTable(val)
            for k,v in pairs(tbl) do
                if k == ply:SteamID() then
                    if v == "" then return end
                    ply:SetModel(v)
                    break
                end
            end
        end
    end)
end)