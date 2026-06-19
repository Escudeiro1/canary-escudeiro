-- Defines coordinate areas for ambient sound zones.
-- Zone names must match the XML entries in otservbr-custom-zones.xml
-- and the keys used in ambient_sounds.lua.

local zones = {
	{
		name = "venore-city",
		from = Position(32840, 32000, 9),
		to   = Position(33050, 32170, 7),
	},
	{
		name = "thais-city",
		-- Dock arrival ~32310,32210,z6; house bounds townid=8: X 32178-32469, Y 32011-32437
		from = Position(32180, 32010, 6),
		to   = Position(32480, 32430, 7),
	},
	{
		name = "carlin-city",
		-- Dock arrival ~32387,31820,z6; house bounds townid=6: X 32168-32520, Y 31600-31847
		from = Position(32330, 31760, 6),
		to   = Position(32490, 31870, 7),
	},
	{
		name = "edron-city",
		-- Dock arrival ~33175,31764,z3-6; island city area
		from = Position(33100, 31700, 3),
		to   = Position(33290, 31880, 7),
	},
	{
		name = "kazordoon-city",
		-- Underground/mountain city; entrances ~32588-32660,31941-31957; covers surface+mines
		from = Position(32530, 31870, 7),
		to   = Position(32710, 31990, 15),
	},
	{
		name = "port-hope-city",
		-- Dock arrival ~32527,32784,z6; jungle city
		from = Position(32450, 32700, 6),
		to   = Position(32640, 32910, 7),
	},
}

for _, zoneData in ipairs(zones) do
	local zone = Zone(zoneData.name)
	if zone then
		zone:addArea(zoneData.from, zoneData.to)
	else
		logger.warn("[ambient_zones] Zone '" .. zoneData.name .. "' not found — check otservbr-custom-zones.xml")
	end
end
