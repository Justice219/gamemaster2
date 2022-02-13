if SERVER then
	gm = gm or {}
	gm.server = gm.server or {}
	gm.server.db = gm.server.db or {}

	gm.server.db.create("gm2_permamodel", {
		[1] = {
			name = "model_tbl",
			type = "TEXT",
		}
	})
end

TOOL.Category		=	"Gamemaster 2"
TOOL.Name			=	"PermaModel"
TOOL.Command		=	nil
TOOL.ConfigName		=	""

if CLIENT then
	language.Add("Tool.gm2_permamodel.name", "PermaModel")
	language.Add("Tool.gm2_permamodel.desc", "Permanently changes a players model")
	language.Add("Tool.gm2_permamodel.0", "Left Click: Model Player, Right Click: Remove Model")

	surface.CreateFont("PermaModelToolScreenFont", { font = "Arial", size = 40, weight = 1000, antialias = true, additive = false })
	surface.CreateFont("PermaModelToolScreenSubFont", { font = "Arial", size = 30, weight = 1000, antialias = true, additive = false })
end

function TOOL:LeftClick(trace)
	if CLIENT then return true end

	gm = gm or {}
	gm.server = gm.server or {}
	gm.server.db = gm.server.db or {}

	local ent = trace.Entity
	if IsValid(ent) and ent:IsPlayer() then
		
	end

	return true
end

function TOOL:RightClick(trace)
	if CLIENT then return true end

	return true
end

function TOOL:Reload(trace)
	if CLIENT then return true end
end

function TOOL.BuildCPanel(panel)

	panel:AddControl("Header",{Text = "PermaModel", Description = "Perma Model\n\nPermanently changes a players model!\n"})

end

function TOOL:DrawToolScreen(width, height)

	if SERVER then return end

	surface.SetDrawColor(17, 148, 240, 255)
	surface.DrawRect(0, 0, 256, 256)

	surface.SetFont("PermaModelToolScreenFont")
	local w, h = surface.GetTextSize(" ")
	surface.SetFont("PermaModelToolScreenSubFont")
	local w2, h2 = surface.GetTextSize(" ")

	draw.SimpleText("Perma Model", "PermaModelToolScreenFont", 128, 100, Color(224, 224, 224, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, Color(17, 148, 240, 255), 4)
	draw.SimpleText("By Justice", "PermaModelToolScreenSubFont", 128, 128 + (h + h2) / 2 - 4, Color(224, 224, 224, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, Color(17, 148, 240, 255), 4)

end
