-- Code by VanessaE and Mossmanikin (and maybe some of Ironzorg's Flowers mod code left)
-- The different sizes of junglegrass used to be part of VanessaE's Plantlife modpack/Junglegrass mod

-- For compatibility with older stuff
minetest.register_alias("junglegrass:shortest","dryplants:junglegrass_shortest")
minetest.register_alias("junglegrass:short"   ,"dryplants:junglegrass_short"   )
minetest.register_alias("junglegrass:medium"  ,"dryplants:junglegrass_medium"  )

local SPAWN_DELAY = 1000
local SPAWN_CHANCE = 200
local GROW_DELAY = 500
local GROW_CHANCE = 30
local junglegrass_seed_diff = 329
	
local grasses_list = {
    {"dryplants:junglegrass_shortest", "dryplants:junglegrass_short" , 1 },
    {"dryplants:junglegrass_short"   , "dryplants:junglegrass_medium", 2 },
    {"dryplants:junglegrass_medium"  , "default:junglegrass"		 , 3 },
    {"default:junglegrass" 			 , nil							 , 4 }
}

minetest.register_node('dryplants:junglegrass_medium', {
	description = "Jungle Grass (medium height)",
	drawtype = 'plantlike',
	tile_images = { 'dryplants_junglegrass_medium.png' },
	inventory_image = 'dryplants_junglegrass_medium.png',
	wield_image = 'dryplants_junglegrass_medium.png',
	sunlight_propagates = true,
	paramtype = 'light',
	walkable = false,
	groups = { snappy = 3, flammable=2, junglegrass=1, flora=1 },
	sounds = default.node_sound_leaves_defaults(),
	drop = 'default:junglegrass',

	selection_box = {
		type = "fixed",
		fixed = {-0.4, -0.5, -0.4, 0.4, 0.5, 0.4},
	},
	buildable_to = true,
})

minetest.register_node('dryplants:junglegrass_short', {
	description = "Jungle Grass (short)",
	drawtype = 'plantlike',
	tile_images = { 'dryplants_junglegrass_short.png' },
	inventory_image = 'dryplants_junglegrass_short.png',
	wield_image = 'dryplants_junglegrass_short.png',
	sunlight_propagates = true,
	paramtype = 'light',
	walkable = false,
	groups = { snappy = 3, flammable=2, junglegrass=1, flora=1 },
	sounds = default.node_sound_leaves_defaults(),
	drop = 'default:junglegrass',
	selection_box = {
		type = "fixed",
		fixed = {-0.4, -0.5, -0.4, 0.4, 0.3, 0.4},
	},
	buildable_to = true,
})

minetest.register_node('dryplants:junglegrass_shortest', {
	description = "Jungle Grass (very short)",
	drawtype = 'plantlike',
	tile_images = { 'dryplants_junglegrass_shortest.png' },
	inventory_image = 'dryplants_junglegrass_shortest.png',
	wield_image = 'dryplants_junglegrass_shortest.png',
	sunlight_propagates = true,
	paramtype = 'light',
	walkable = false,
	groups = { snappy = 3, flammable=2, junglegrass=1, flora=1 },
	sounds = default.node_sound_leaves_defaults(),
	drop = 'default:junglegrass',
	selection_box = {
		type = "fixed",
		fixed = {-0.3, -0.5, -0.3, 0.3, 0, 0.3},
	},
	buildable_to = true,
})

if JUNGLEGRASS_SPAWNING == true then -- see settings.txt
plantslib:spawn_on_surfaces({
	spawn_delay = SPAWN_DELAY,
	spawn_plants = {"dryplants:junglegrass_shortest"},
	avoid_radius = 4,
	spawn_chance = SPAWN_CHANCE,
	spawn_surfaces = {"default:dirt_with_grass", "default:cactus", "default:papyrus"},
	avoid_nodes = {"group:junglegrass", "default:junglegrass", "default:dry_shrub"},
	seed_diff = junglegrass_seed_diff,
	light_min = 5
})

plantslib:spawn_on_surfaces({
	spawn_delay = SPAWN_DELAY,
	spawn_plants = {"dryplants:junglegrass_shortest"},
	avoid_radius = 4,
	spawn_chance = SPAWN_CHANCE*2,
	spawn_surfaces = {"default:sand"},
	avoid_nodes = {"group:junglegrass", "default:junglegrass", "default:dry_shrub"},
	seed_diff = junglegrass_seed_diff,
	light_min = 5
})

plantslib:spawn_on_surfaces({
	spawn_delay = SPAWN_DELAY,
	spawn_plants = {"dryplants:junglegrass_shortest"},
	avoid_radius = 4,
	spawn_chance = SPAWN_CHANCE*5,
	spawn_surfaces = {"default:desert_sand"},
	avoid_nodes = {"group:junglegrass", "default:junglegrass", "default:dry_shrub"},
	seed_diff = junglegrass_seed_diff,
	light_min = 5
})
end


abstract_dryplants.junglegrass = function(pos)
	for i in pairs(grasses_list) do
		local SiZe 	= 	math.random(1,4)
		local GRaSS = 	grasses_list[i][1]
		local NR 	= 	grasses_list[i][3]
		local right_here = {x=pos.x, y=pos.y+1, z=pos.z}
		local node_here  = minetest.get_node(right_here)
		if minetest.registered_nodes[node_here.name].buildable_to -- instead of check_air = true,
		and SiZe == NR 
		and NR ~= 4 then
			minetest.add_node(right_here, {name=GRaSS})
		end
	end
end

plantslib:register_generate_plant({
    surface = {
		"default:dirt_with_grass",
		"default:sand",
		"default:desert_sand"	
	},
    max_count = JUNGLEGRASS_PER_MAPBLOCK,
    rarity = 101 - JUNGLEGRASS_RARITY,
	seed_diff = junglegrass_seed_diff,
    min_elevation = 1, -- above sea level
	max_elevation = 40,
	near_nodes = {"default:jungletree", "default:junglegrass"},
	near_nodes_size = 3,
	near_nodes_vertical = 2,
	near_nodes_count = 1,
	plantlife_limit = -0.9,
	check_air = false,
  },
  "abstract_dryplants.junglegrass"
)

-- add junglegrass on cacti?

-- todo: farming
		
for i in ipairs(grasses_list) do
	plantslib:grow_plants({
		grow_delay = GROW_DELAY,
		grow_chance = GROW_CHANCE/2,
		grow_plant = grasses_list[i][1],
		grow_result = grasses_list[i][2],
		dry_early_node = "default:desert_sand",
		grow_nodes = {"default:dirt_with_grass", "default:sand", "default:desert_sand"}
	})
end

print("[Junglegrass] Loaded.")
