gm = gm or {}
gm.server = gm.server or {}
gm.server.db = gm.server.db or {}
gm.server.chat = gm.server.chat or {}
gm.server.net = gm.server.net or {}
gm.server.errors = gm.server.errors or {}
gm.server.main = gm.server.main or {}

gm.server.data = gm.server.data or {}
gm.server.data.main = gm.server.data.main or {}

gm.server.db.create("gamemaster2", {
    [1] = {
        name = "config_tbl",
        type = "TEXT",
    }
})

function gm.server.main.addRank(rank)
    if gm.server.data.main.ranks[rank] then
        gm.server.errors.severe("Rank: " .. rank .. "already exists")   
    return end

    local val = gm.server.db.loadAll("gamemaster2", "config_tbl")
    if val then
        local tbl = util.JSONToTable(val)
        tbl.ranks[rank] = true
        
        gm.server.data.main.ranks[rank] = true
        gm.server.db.updateAll("gamemaster2", "config_tbl", util.TableToJSON(tbl))
        gm.server.errors.change("Rank: " .. rank .. " added")
    else
        local tbl = {}
        tbl.ranks = {}
        tbl.ranks[rank] = true

        gm.server.data.main.ranks[rank] = true
        gm.server.db.updateAll("gamemaster2", "config_tbl", util.TableToJSON(tbl))
        gm.server.errors.change("Rank: " .. rank .. " added")
    end
end
function gm.server.main.removeRank(rank)
    if !gm.server.data.main.ranks[rank] then
        gm.server.errors.severe("Rank: " .. rank .. "does not exist")
    return end

    local val = gm.server.db.loadAll("gamemaster2", "config_tbl")
    if val then
        local tbl = util.JSONToTable(val)
        tbl.ranks[rank] = nil

        gm.server.data.main.ranks[rank] = nil
        gm.server.db.updateAll("gamemaster2", "config_tbl", util.TableToJSON(tbl))
        gm.server.errors.change("Rank: " .. rank .. " removed")
    else
        gm.server.errors.severe("There is no config table")
    end
end
function gm.server.main.load()
    local val = gm.server.db.loadAll("gamemaster2", "config_tbl")
    if val then
        gm.server.data.main = util.JSONToTable(val)
    else
        gm.server.data.main = {}
        gm.server.data.main.ranks = {}
        gm.server.errors.severe("No config table found, save some data first")
    end
end

gm.server.main.load()