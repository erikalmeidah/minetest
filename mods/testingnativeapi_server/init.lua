minetest.log("info", "[testing] modname="..dump(minetest.get_current_modname()))
minetest.log("info", "[testing] modpath="..dump(minetest.get_modpath("testingnativeapi_server")))

minetest.register_on_mods_loaded(function()
	minetest.log("action", "[testing] on_mods_loaded()")
end)

local modpath = minetest.get_modpath("testingnativeapi_server")

-- Load test suite
native_tests = dofile(modpath .. "/native_tests.lua")

-- Load class files
dofile(modpath .. "/auth.lua")
dofile(modpath .. "/areastore.lua")
dofile(modpath .. "/inventory.lua")
dofile(modpath .. "/particles.lua")
dofile(modpath .. "/settings.lua")
dofile(modpath .. "/noise.lua")
dofile(modpath .. "/nodetimer.lua")
dofile(modpath .. "/rollback.lua")
dofile(modpath .. "/object.lua")



-- Load helper files
dofile(modpath .. "/other.lua")
dofile(modpath .. "/server_test.lua")
dofile(modpath .. "/client_tools.lua")
