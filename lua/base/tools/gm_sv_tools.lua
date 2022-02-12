gm = gm or {}
gm.server = gm.server or {}
gm.server.tools = gm.server.tools or {}
gm.server.errors = gm.server.errors or {}

gm.server.data = gm.server.data or {}
gm.server.data.tools = gm.server.data.tools or {}

function gm.server.tools.add(name, tbl)
    if gm.server.data.tools[name] then
        gm.server.errors.severe("Tool already registered: " .. name)
    end

    gm.server.data.tools[name] = {
        name = name,
        desc = tbl.desc,
        author = tbl.author,
        func = tbl.func,
        category = tbl.category,
        args = tbl.args,
    }
    gm.server.errors.change("Tool registered: " .. name)
end
function gm.server.tools.remove(name)
    if not gm.server.data.tools[name] then
        gm.server.errors.severe("Tool not registered: " .. name)
    end

    gm.server.data.tools[name] = nil
end
function gm.server.tools.run(name, ply, args)
    if not gm.server.data.tools[name] then
        gm.server.errors.severe("Tool not registered: " .. name)
    end

    gm.server.data.tools[name].func(ply, args)
end
