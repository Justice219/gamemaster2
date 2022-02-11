gm = gm or {}
gm.server = gm.server or {}
gm.server.tools = gm.server.tools or {}
gm.server.errors = gm.server.errors or {}

gm.server.data = gm.server.data or {}
gm.server.data.tools = gm.server.data.tools or {}

gm.server.tools.add("Screen Shake", {
    desc = "Shakes the entire servers screen",
    author = "Justice",
    category = "Server",
    args = {
        ["Magnitude"] = {
            name = "Magnitude",
            desc = "The magnitude of the shake",
            type = "number",
            def = 5
        },
        ["Duration"] = {
            name = "Duration",
            desc = "The duration of the shake",
            type = "number",
            def = 5
        },
    },
    func = function(caller, args)
        local magnitude = args["Magnitude"].def
        local duration = args["Duration"].def
        
        util.ScreenShake(Vector(0, 0, 0), magnitude, duration, 10, 9999999)
    end
})
gm.server.tools.add("Black Screen", {
    desc = "Makes the entire servers screen black",
    author = "Justice",
    category = "Server",
    args = {
        ["Duration"] = {
            name = "Duration",
            desc = "The duration of the black screen",
            type = "number",
            def = 10
        },
        ["Fade Time"] = {
            name = "Fade Time",
            desc = "The time it takes to fade the screen in and out",
            type = "number",
            def = 75
        },
    },
    func = function(caller, args)
        print("Black Screen")
        net.Start("GM2:Tools:BlackScreen")
        net.WriteTable({            -- SINCE WE DONT WANT THE GAMEMASTER TO SEE THE BLACK SCREEN
            ["Founder"] = true,     -- LETS RESTRICT WHO CANT SEE IT!!!
            ["Gamemaster"] = true,
        })
        net.WriteInt(args["Duration"].def, 32)
        net.WriteInt(args["Fade Time"].def, 32)
        net.Broadcast()
    end
})
gm.server.tools.add("Screen Message", {
    desc = "Makes the entire servers screen black",
    author = "Justice",
    category = "Server",
    args = {
        ["Duration"] = {
            name = "Duration",
            desc = "The duration of the message",
            type = "number",
            def = 5
        },
        ["Color"] = {
            name = "Color",
            desc = "The color of the message (Must be in format #,#,#)",
            type = "string",
            def = "255,255,255"
        },
        ["Message"] = {
            name = "Message",
            desc = "The message to display",
            type = "string",
            def = "This is a test message"
        },
        ["Fade Time"] = {
            name = "Fade Time",
            desc = "The message to display",
            type = "number",
            def = 75
        },
    },
    func = function(caller, args)
        local c = string.Explode(",", args["Color"].def)
        local color = Color(c[1], c[2], c[3])

        net.Start("GM2:Tools:ScreenMessage")
        net.WriteString(args["Message"].def)
        net.WriteColor(color)
        net.WriteInt(args["Duration"].def, 32)
        net.WriteInt(args["Fade Time"].def, 32)
        net.Broadcast()
    end
})
gm.server.tools.add("Screen Timer", {
    desc = "Shows a timer for the entire server, Set to zero to remove or let run out!",
    author = "Justice",
    category = "Server",
    args = {
        ["Time"] = {
            name = "Time",
            desc = "The number for the timer to display",
            type = "number",
            def = 5
        },
    },
    func = function(caller, args)
        if args["Time"].def == 0 then
            if timer.Exists("gm_timer") then
                timer.Remove("gm_timer")
                hook.Remove("PlayerInitialSpawn", "gm_timerSync")
                net.Start("GM2:Tools:ScreenTimerStop")
                net.Broadcast()
            end
        else
            if timer.Exists("gm_timer") then
                timer.Remove("gm_timer")
                timer.Create("gm_timer", args["Time"].def, 1, function()
                    hook.Remove("PlayerInitialSpawn", "gm_timerSync")
                 end)
            else
                timer.Create("gm_timer", args["Time"].def, 1, function()
                    hook.Remove("PlayerInitialSpawn", "gm_timerSync")
                end)
            end

            net.Start("GM2:Tools:ScreenTimerStart")
            net.WriteInt(args["Time"].def, 32)
            net.Broadcast()

            hook.Add("PlayerInitialSpawn", "gm_timerSync", function(ply)
                if timer.Exists("gm_timer") then
                    net.Start("GM2:Tools:ScreenTimerSync")
                    net.WriteInt(timer.TimeLeft("gm_timer"), 32)
                    net.Send(ply)
                else
                    hook.Remove("PlayerInitialSpawn", "gm_timerSync")
                end
            end)
        end
    end
})
gm.server.tools.add("Set Opsat", {
    desc = "Creates an opsat that shows the players on the server, make title empty to remove!",
    author = "Justice",
    category = "Server",
    args = {
        ["Title 1"] = {
            name = "Title 1",
            desc = "The title of the first column",
            type = "string",
            def = "Information"
        },
        ["Line 1"] = {
            name = "Line 1",
            desc = "The line of text for the first column",
            type = "string",
            def = "Planet: KG3"
        },
        ["Line 2"] = {
            name = "Line 2",
            desc = "The second line of text for the first column",
            type = "string",
            def = "Era: 22BBY"
        },
        ["Title 2"] = {
            name = "Title 2",
            desc = "The title of the first column",
            type = "string",
            def = "Objective"
        },
        ["Line 3"] = {
            name = "Line 3",
            desc = "The line of text for the second column",
            type = "string",
            def = "- Kill CIS Commander"
        },
        ["Line 4"] = {
            name = "Line 4",
            desc = "The second line of text for the second column",
            type = "string",
            def = "- Raid CIS Base"
        },
    },
    func = function(caller, args)
        if args["Title 1"].def == "" then
            net.Start("GM2:Tools:OpsatRemove")
            net.WriteTable(args)
            net.Broadcast()

            hook.Remove("PlayerInitialSpawn", "gm_opsatSync")
        else            
            net.Start("GM2:Tools:OpsatSet")
            net.WriteTable(args)
            net.Broadcast()

            hook.Add("PlayerInitialSpawn", "gm_opsatSync", function(ply)
                net.Start("GM2:Tools:OpsatSet")
                net.WriteTable(args)
                net.Broadcast()
            end)
        end
    end
})
gm.server.tools.add("Kill Player", {
    desc = "Silently kills a player, make sure their name is correct!",
    author = "Justice",
    category = "Player",
    args = {
        ["Name"] = {
            name = "Player Name",
            desc = "The name of the player",
            type = "string",
            def = "Justice"
        },
    },
    func = function(caller, args)
        for k,v in pairs(player.GetAll()) do
            if v:Nick() == args["Name"].def then
                v:Kill()
            end
        end
    end
})