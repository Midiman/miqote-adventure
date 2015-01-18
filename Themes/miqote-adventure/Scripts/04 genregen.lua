-- GenreGen, Version 1.1
-- Written by Vyhd (http://boxorroxors.net/)

-- Licensed under Creative Commons Attribution-Share Alike 3.0 Unported
-- ( http://creativecommons.org/licenses/by-sa/3.0/ )
-- All I ask is that you keep this notice intact. :)

-- Shoutouts to Konami for making an awesome game and filling it with
-- ridiculous genres. Every single string here is straight from IIDX. :>

GenreGen = {}

GenreGen.Defs =
{
	-- the main genre. may be listed on its own.
	Main =
	{
		"2Step",
		"Africa",
		"Ambient",
		"America",
		"Baroque",
		"Beat",
		"Bossa",
		"Breaks", 
		"Breakbeat",
		"Cabaret",
		"Celtrance",
		"Chanson",
		"Choir",
		"Concerto",
		"Crossover",
		"Cuddlecore",
		"Dance",
		"Dirge",
		"Disco",
		"Drum & Bass",
		"Electro",
		"Electrock",
		"Electronic",
		"Extreme",
		"France",
		"Full On",
		"Funk",
		"Fusion",
		"Gabba",
		"Gabber",
		"Handz Up",
		"Hardcore",
		"House",
		"Instrumental",
		"Japan", 
		"J-Pop",
		"J-Pop+",
		"J-Rock",
		"Jungle",
		"K-Groove",
		"Latin Horns",
		"Lounge",
		"Minimal",
		"Mixture",
		"Nu-NRG",
		"Opera",
		"Opus",
		"Oratorio",
		"Orchestral",
		"Paradise",
		"Piano'n'Bass",
		"Poetry",
		"Pop",
		"Pops",
		"Progressive",
		"Psychedelic",
		"Renaissance",
		"Requiem",
		"Rock",
		"Salsa",
		"Schranz",
		"Slowcore",
		"Softcore",
		"Sonata",
		"Soul",
		"Sound",
		"Spiritual",
		"Swing",
		"Techno",
		"Tec-Drum'n'Bass",
		"Tek",
		"Trance",
		"Waltz",
	};

	-- a secondary descriptor, which is likely be shown.
	Desc1 =
	{
		"Asian",
		"Beat",
		"BigBeat",
		"Broken",
		"Buchiage",
		"Click",
		"Club",
		"Country",
		"Cute",
		"Cyber",
		"Cyborg",
		"Death",
		"Deceptive",
		"Dutch",
		"Epic",
		"Erhu",
		"Electric",
		"Esoteric",
		"Ethno",
		"Euro",
		"Freeform",
		"Garage",
		"Goa",
		"Gothic",
		"Happy",
		"Hard",
		"Hindu",
		"Hip",
		"Italo",
		"J-Happy",
		"Lovers",
		"Medieval",
		"Millennium",
		"Natural",
		"Noise",
		"Nostalish",
		"Nustyle",
		"Power",
		"Punk",
		"Ragga",
		"Reckless",
		"Rococo",
		"Sadistic",
		"Scouse",
		"Spanish",
		"Speed",
		"Sublime",
		"SuperNOVA",
		"Tribal",
		"Turkish",
		"World",
	};

	-- tertiary descriptor. shouldn't appear often.
	Desc2 =
	{
		"Alternative",
		"Dramatic",
		"High Speed",
		"Hyper",
		"Lovely",
		"Oldskool",
		"Nu",
		"Super",
		"Synthetic",
	};
};


-- GenreGen, Version 1.1
-- Written by Vyhd (http://boxorroxors.net/)

-- Licensed under Creative Commons Attribution-Share Alike 3.0 Unported
-- ( http://creativecommons.org/licenses/by-sa/3.0/ )
-- All I ask is that you keep this notice intact. :)

-- Callable functions:
-- GenreGen.Generate() - generates a genre from GAMESTATE's current song
-- GenreGen.GenerateFromSong( song ) - generates a genre from a specified song

-- LUA 5.0 compatibility call
local function GetRandom( tbl )
	local max = table.getn(tbl)
	return tbl[math.random(max)]	
end

-- I love having an excuse to name functions like this.
local function IsKyleWard( artist )
	-- that last one is Smiley, if you didn't know.
	local KeeL_aliases = { "Banzai", "Inspector K", "KaW", "KBit", "KeeL", "☺" };

	for i=1,table.getn(KeeL_aliases) do
		if artist == KeeL_aliases[i] then return true end
	end

	return false
end

local function GetGenreString( song, num )
	-- first, a few Easter eggs...

	-- if this is a patched OGG, then set this genre instead.
	if song:MusicLengthSeconds() == 105 then return "Crunchy H4X" end

	local artist = song:GetTranslitArtist()

	-- lol hi dax :>
	if artist == "Dax" then return "Alternative Crapcore" end

	-- now that we've had our fun, create the genre string
	local sRet = ""

	-- this seems backward, because the random() calls are made in
	-- the same order as older scripts to generate the same genres.
	if num >= 3 then sRet = sRet .. GetRandom(GenreGen.Defs.Desc2) .. " " end
	if num >= 2 then sRet = sRet .. GetRandom(GenreGen.Defs.Desc1) .. " " end

	-- lol hi kyle :>
	if IsKyleWard( artist ) then
		sRet = sRet .. "K-" .. GetRandom(GenreGen.Defs.Main)
	else
		sRet = sRet .. GetRandom(GenreGen.Defs.Main)
	end

	return sRet
end

-- alias function for current song
function GenreGen.Generate()
	return GenreGen.GenerateFromSong( GAMESTATE:GetCurrentSong() )
end

function GenreGen.GenerateFromSong( song )
	if not song then return "" end

	-- randomseed truncates float values, but we need more randomness.
	-- move the number over several digits to compensate.
	local factor = 10000
	math.randomseed( factor*song:MusicLengthSeconds() )

	-- Vary the amount of words returned, based on the seed.
	local rand = math.random()

	-- chances for word amount:
	-- 2/10 for one, 7/10 for two, 1/10 for three
	if rand < 0.2 then num = 1
	elseif rand > 0.9 then num = 3
	else num = 2 end

	return GetGenreString( song, num )
end
