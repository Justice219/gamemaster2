gm = gm or {}
gm.server = gm.server or {}
gm.server.tools = gm.server.tools or {}
gm.server.errors = gm.server.errors or {}

gm.server.data = gm.server.data or {}
gm.server.data.tools = gm.server.data.tools or {}
gm.server.data.temp = gm.server.data.temp or {}

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
            ["superadmin"] = true,
            ["Admin"] = true,
            ["Builder"] = true,
            ["builder"] = true,
        })
        net.WriteInt(args["Duration"].def, 32)
        net.WriteInt(args["Fade Time"].def, 32)
        net.Broadcast()
        caller:JLIBSendNotification("Black Screen", "Black Screen has been toggled")
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
            caller:JLIBSendNotification("Opsat", "Opsat has been removed")
        else            
            net.Start("GM2:Tools:OpsatSet")
            net.WriteTable(args)
            net.Broadcast()

            hook.Add("PlayerInitialSpawn", "gm_opsatSync", function(ply)
                net.Start("GM2:Tools:OpsatSet")
                net.WriteTable(args)
                net.Broadcast()
            end)
            caller:JLIBSendNotification("Opsat", "Opsat has been set")
        end
    end
})
gm.server.tools.add("Kill Player", {
    desc = "Silently kills a player, make sure their name is correct!",
    author = "Justice",
    category = "Player",
    args = {
        ["Player Name"] = {
            name = "Player Name",
            desc = "The name of the player",
            type = "string",
            def = "Garry"
        },
    },
    func = function(caller, args)
        for k,v in pairs(player.GetAll()) do
            if v:Nick() == args["Name"].def then
                v:Kill()
                caller:JLIBSendNotification("Kill PLayer", "You have killed " .. v:Nick())
            else
                caller:JLIBSendNotification("Kill PLayer", "Player not found")
            end
        end
    end
})
gm.server.tools.add("Kill Entities", {
    desc = "Kills all of a specific entity, make sure the entity name is correct!",
    author = "Justice",
    category = "World",
    args = {
        ["Entity Path"] = {
            name = "Entity Path",
            desc = "The path of the entity (Ex.) npc_monk)",
            type = "string",
            def = "npc_monk"
        },
    },
    func = function(caller, args)
        for k,v in pairs(ents.GetAll()) do
            if v:GetClass() == args["Path"].def then
                v:Remove()
            end
            caller:JLIBSendNotification("Kill Entities", "You have removed all of the " .. args["Path"].def .. " entities!")
        end
    end
})
gm.server.tools.add("Player ESP", {
    desc = "Gives you esp of the entire server. Run again to remove!",
    author = "Justice",
    category = "World",
    args = {},
    func = function(caller, args)
        net.Start("GM2:Net:ClientConvar")
        if caller.jesp then 
            caller.jesp = false
            net.WriteBool(false)
        else
            caller.jesp = true
            net.WriteBool(true)
        end
        net.WriteString("gm2_esp")
        net.Send(caller)

        caller:JLIBSendNotification("World ESP", "You have toggled esp!")
    end
})
gm.server.tools.add("Levitate", {
    desc = "Levitates a player, make sure their name is correct! THIS is dangerous and will send them high in the air!",
    author = "Justice",
    category = "Player",
    args = {
        ["Player Name"] = {
            name = "Player Name",
            desc = "The name of the player",
            type = "string",
            def = "Garry"
        },
        ["Duration"] = {
            name = "Duration",
            desc = "The duration of the levitation",
            type = "number",
            def = 5
        },
    },
    func = function(caller, args)
        for k,v in pairs(player.GetAll()) do
            if v:Nick() == args["Player Name"].def then
                v:SetGravity(-1)
                net.Start("GM2:Net:StringConCommand")
                net.WriteString("+jump")
                net.Send(v)
                timer.Simple(args["Duration"].def, function()
                    if IsValid(v) then
                        v:SetGravity(1)
                        net.Start("GM2:Net:StringConCommand")
                        net.WriteString("-jump")
                        net.Send(v)
                    end
                end)
                caller:JLIBSendNotification("Levitate", "You have sent " .. v:Nick().. " In the air!")
            end
        end
    end
})
gm.server.tools.add("Toggle Flashlights", {
    desc = "Disable or enable flashlights for all players! Run to enable and again to disable!",
    author = "Justice",
    category = "Server",
    args = {
    },
    func = function(caller, args)
        if gm.server.data.temp.flashlights then
            gm.server.data.temp.flashlights = false
            for k,v in pairs(player.GetAll()) do
                v:AllowFlashlight(true)
            end
            hook.Remove("PlayerInitialSpawn", "gm_flashlights")
            caller:JLIBSendNotification("Toggle Flashlights", "Flashlights are now enabled!")
        else
            gm.server.data.temp.flashlights = true
            for k,v in pairs(player.GetAll()) do
                v:AllowFlashlight(false)
            end
            hook.Add("PlayerInitialSpawn", "gm_flashlights", function(ply)
                ply:AllowFlashlight(false)
            end)
            caller:JLIBSendNotification("Toggle Flashlights", "Flashlights are now disabled!")
        end
    end
})
gm.server.tools.add("Disable Lights", {
    desc = "Disbable all lights in the map!",
    author = "Justice",
    category = "World",
    args = {},
    func = function(caller, args)
        if gm.server.data.temp.lights then
            gm.server.data.temp.lights = false
            
            engine.LightStyle(0, "m")
            net.Start("GM2:Tools:EnableLights")
            net.Broadcast()

            caller:JLIBSendNotification("Disable Lights", "Lights are now enabled!")
        else    
            gm.server.data.temp.lights = true

            engine.LightStyle(0, "a")
            net.Start("GM2:Tools:EnableLights")
            net.Broadcast()
            
            caller:JLIBSendNotification("Disable Lights", "Lights are now disabled!")
        end
    end
})
gm.server.tools.add("Disable OOC", {
    desc = "Disables OOC for all players!",
    author = "Justice",
    category = "Server",
    args = {},
    func = function(caller, args)
        if gm.server.data.temp.oocDisable then
            gm.server.data.temp.oocDisable = false
            hook.Remove("PlayerSay", "gm_ooc")
            caller:JLIBSendNotification("Disable OOC", "OOC is now enabled!")
        else
            gm.server.data.temp.oocDisable = true
            hook.Add("PlayerSay", "gm_ooc", function(ply, text)
                local txt = string.explode(" ", text)
                if txt[1] == "/ooc" then
                    return ""
                else
                    return text
                end
            end)
            caller:JLIBSendNotification("Disable OOC", "OOC is now disabled!")
        end
    end
})
gm.server.tools.add("Server Lives", {
    desc = "Creates a lives system for the server!",
    author = "Justice",
    category = "Server",
    args = {
        ["Lives"] = {
            name = "Lives",
            desc = "The amount of lives you want the server to have",
            type = "number",
            def = 3
        },
    },
    func = function(caller, args)
        local function findAlivePlayer()
            local targ
            for k,v in pairs(player.GetAll()) do -- micro optimisations 
                if v && v:IsValid() && v:Alive() then
                    targ = v
                    break -- found someone kill loop fast.
                end
            end
            return targ
        end

        if gm.server.data.temp.lives then
            hook.Remove("PlayerDeath", "gm_lives")
            hook.Remove("PlayerDeathThink", "gm_lives2")
            gm.server.data.temp.lives = false
            caller:JLIBSendNotification("Server Lives", "Lives are now disabled!")
            for k,v in pairs(player.GetAll()) do
                v:UnSpectate()
                v:Respawn()
                v:JLIBChatNotify("Lives", "Lives have been disabled! You can now respawn!")
            end
        else
            for k,v in pairs(player.GetAll()) do
                v:SetNWInt("gm2_lives", args["Lives"].def)
                v:JLIBChatNotify("Lives", "Lives have been enabled! You have " .. args["Lives"].def .. " lives!")
            end
            hook.Add("PlayerDeath", "gm_lives", function(ply, killer, attacker)
                ply:SetNWInt("gm2_lives", ply:GetNWInt("gm2_lives") - 1)
                if ply:GetNWInt("gm2_lives") <= 0 then
                    ply:JLIBChatNotify("Lives", "You have died and are spectating!")

                    ply:Spectate(OBS_MODE_CHASE)
                    ply:SpectateEntity(findAlivePlayer())
                else
                    ply:JLIBChatNotify("Lives", "You have died and have " .. ply:GetNWInt("gm2_lives") .. " lives left!")
                end
                
            end)
            hook.Add("PlayerDeathThink", "gm_lives2", function(ply)
                if ply:GetNWInt("gm2_lives") == 0 then
                    return false
                end     
            end)
            gm.server.data.temp.lives = true
            caller:JLIBSendNotification("Lives", "Lives are now enabled!")
        end
    end
})