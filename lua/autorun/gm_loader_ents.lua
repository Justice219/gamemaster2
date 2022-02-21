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
    -- Model Giver
    util.AddNetworkString("GM2:Entities:WeaponGiver:Give")
    util.AddNetworkString("GM2:Entities:WeaponGiver:Set")
    util.AddNetworkString("GM2:Entities:WeaponGiver:Open")
    util.AddNetworkString("GM2:Entities:WeaponGiver:Verify")

    util.AddNetworkString("GM2:Entities:ModelGiver:Give")
    util.AddNetworkString("GM2:Entities:ModelGiver:Set")
    util.AddNetworkString("GM2:Entities:ModelGiver:Open")
    util.AddNetworkString("GM2:Entities:ModelGiver:Verify")
end