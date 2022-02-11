gm = gm or {}
gm.server = gm.server or {}
gm.server.db = gm.server.db or {}
gm.server.errors = gm.server.errors or {}

function gm.server.db.query(query)
    gm.server.errors.debug("Query: " .. query)
    sql.Query(query)
end

function gm.server.db.create(name, values)
    local str = ""
    local i = 0
    local max = table.maxn(values)
    for k,v in pairs(values) do
        -- the string needs to look something like id NUMBER, name TEXT
        i = i + 1
        if i == max then 
            str = str .. v.name .. " " .. v.type
        else
            str = str .. v.name .. " " .. v.type .. ", "
        end
    end

    sql.Query("CREATE TABLE IF NOT EXISTS " .. name .. " ( " .. str .. " )")
    gm.server.errors.change("Created new DB table: " .. name)
    if !sql.LastError() then return end
    gm.server.errors.change("Printing last SQL Error for debugging purposes, ")
    print(sql.LastError())
end

function gm.server.db.remove(name)
    sql.Query("DROP TABLE " .. name)

    gm.server.errors.change("Removed DB table: " .. name)
    if !sql.LastError() then return end
    gm.server.errors.change("Printing last SQL Error for debugging purposes, ")
end

function gm.server.db.updateSpecific(name, row, method, value, key)
    local data = sql.Query("SELECT " .. row .. " FROM " .. name .. " WHERE " .. method .. " = " ..sql.SQLStr(key).. ";")
    if (data) then
        sql.Query("UPDATE " .. name .. " SET " .. row .. " = " .. sql.SQLStr(value) .. " WHERE " .. method .. " = " ..sql.SQLStr(key).. ";")
    else
        sql.Query("INSERT INTO " .. name .. " ( "..method..", "..row.." ) VALUES( "..sql.SQLStr(key)..", "..sql.SQLStr(value).." );")
    end
end

function gm.server.db.updateAll(name, row, value)
    gm.server.errors.change("Updating all entries in DB table: " .. name)
    value = sql.SQLStr(value)
    local data = sql.Query("SELECT * FROM " .. name .. ";")
    if (data) then
        sql.Query("UPDATE " .. name .. " SET " .. row .. " = " .. value .. ";")
    else
        sql.Query("INSERT INTO " .. name .. " ( "..row.." ) VALUES( "..value.." )") 
    end
end

function gm.server.db.load(name, method)
    local val = sql.QueryValue("SELECT * FROM " .. name .. " WHERE " .. method .. " = " .. sql.SQLStr(method) .. ";")
    if !val then
        gm.server.errors.severe("Could not load data from DB table: " .. name .. " with method: " .. method)    
        return false
    else
        return val
    end
end

function gm.server.db.loadSpecific(name, row, method, key)
    local val = sql.QueryValue("SELECT " .. row .. " FROM " .. name .. " WHERE " .. method .. " = " .. sql.SQLStr(key) .. ";")
    if !val then
        gm.server.errors.severe("Could not load data from DB table: " .. name .. " with method: " .. method)    
        return false
    else
        return val
    end
end

function gm.server.db.loadAll(name, row)
    local val = sql.QueryValue("SELECT "..row.." FROM " .. name .. ";")
    if !val then
        gm.server.errors.severe("Could not load data from DB table: " .. name)    
        return false
    else
        return val
    end
end