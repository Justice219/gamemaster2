--[[

 $$$$$$\  $$\      $$\       $$\    $$\  $$$$$$\  
$$  __$$\ $$$\    $$$ |      $$ |   $$ |$$  __$$\ 
$$ /  \__|$$$$\  $$$$ |      $$ |   $$ |\__/  $$ |
$$ |$$$$\ $$\$$\$$ $$ |      \$$\  $$  | $$$$$$  |
$$ |\_$$ |$$ \$$$  $$ |       \$$\$$  / $$  ____/ 
$$ |  $$ |$$ |\$  /$$ |        \$$$  /  $$ |      
\$$$$$$  |$$ | \_/ $$ |         \$  /   $$$$$$$$\ 
 \______/ \__|     \__|          \_/    \________|
                                                  
 A System created by: Justice#4956

 GM 2.0 is a system created for gamemasters to be able to produce higher 
 quality events with a bunch of tools to make player experience more enjoyable
 and immersive.

 This system was created for the use of Prime Gaming Network, and is only
 permitted to be used by the owners of that network and me obviosuly.

]]--

if SERVER then
    -- DO NOT TOUCH THIS FUCKING LOAD ORDER TY!!
    MsgC(Color(255,0,0), "[GM 2.0] ", Color(255,255,255), "Loading GM 2.0...\n")

    -- Lets add network strings
    util.AddNetworkString("GM2:Menus:Main")
    util.AddNetworkString("GM2:Tools:Run")
    util.AddNetworkString("GM2:Tools:BlackScreen")
    util.AddNetworkString("GM2:Tools:ScreenMessage")
    util.AddNetworkString("GM2:Tools:ScreenTimerStart")
    util.AddNetworkString("GM2:Tools:ScreenTimerStop")
    util.AddNetworkString("GM2:Tools:ScreenTimerSync")
    util.AddNetworkString("GM2:Tools:OpsatSet")
    util.AddNetworkString("GM2:Tools:OpsatRemove")
    util.AddNetworkString("GM2:Net:PanelAccess")
    util.AddNetworkString("GM2:Net:ClientConvar")
    util.AddNetworkString("GM2:Net:StringConCommand")
    util.AddNetworkString("GM2:Tools:EnableLights")

    -- Lets AddCSLuaFile all the client files
    AddCSLuaFile("base/ui/gm_ui_main.lua")
    AddCSLuaFile("base/net/gm_cl_net.lua")
    AddCSLuaFile("base/ui/gm_ui_blackscreen.lua")
    AddCSLuaFile("base/ui/gm_ui_screenmessage.lua")
    AddCSLuaFile("base/ui/gm_ui_timer.lua")
    AddCSLuaFile("base/ui/gm_ui_opsat.lua")

    -- Lets include the base files
    include("base/debug/gm_sv_errors.lua")
    include("base/db/gm_sv_db.lua")

    -- Lets include the tools now
    include("base/tools/gm_sv_tools.lua")
    include("base/config/gm_config_tools.lua")

    -- Lets load any files that need to be loaded after everything else
    include("base/main/gm_sv_main.lua")
    include("base/chat/gm_sv_chat.lua")
    include("base/net/gm_sv_net.lua")
end
if CLIENT then
    -- Lets include the base files
    include("base/ui/gm_ui_main.lua")
    include("base/net/gm_cl_net.lua")
    include("base/ui/gm_ui_blackscreen.lua")
    include("base/ui/gm_ui_screenmessage.lua")
    include("base/ui/gm_ui_timer.lua")
    include("base/ui/gm_ui_opsat.lua")
end