-- Written By Sean Ferguson and Songyuhao Shi
minetest.log("object_test_obj")

minetest.register_chatcommand("lua_object", {
    description = "List all avaliable chat commands",
    func = function(name, param)
        if param == "" then
            minetest.log("Enter a page number - /lua_object #")
        end
        if param == "1" then
            minetest.log("lua_object_remove\n")
            minetest.log("lua_object_get_pos\n")
            minetest.log("lua_object_set_pos #\n")
            minetest.log("lua_object_move_to #\n")
            minetest.log("lua_object_punch - Not Working\n")
            minetest.log("lua_object_right_click\n")
            minetest.log("lua_object_set_hp\n")
            minetest.log("lua_object_get_hp\n")
            minetest.log("lua_object_get_inventory\n")
            minetest.log("lua_object_get_wield_list\n")
        end
        if param == "2" then
            minetest.log("lua_object_get_wield_index\n")
            minetest.log("lua_object_get_wielded_item\n")
            minetest.log("lua_object_set_wielded_item\n")
            minetest.log("lua_object_set_armor_groups - Not Working\n")
            minetest.log("lua_object_get_armor_groups\n")
            minetest.log("lua_object_set_animation - Not Working\n")
            minetest.log("lua_object_get_animation\n")
            minetest.log("lua_object_set_local_animation - Not Working\n")
            minetest.log("lua_object_get_local_animation\n")
            minetest.log("lua_object_get_eye_offset\n")
        end
        if param == "3" then
            minetest.log("lua_object_set_eye_offset #")
            minetest.log("lua_object_send_mapblock")
            minetest.log("")
            minetest.log("")
            minetest.log("")
            minetest.log("")
            minetest.log("")
            minetest.log("")
            minetest.log("")
            minetest.log("")
        end
        --Chris Functions
        if param == "4" then
            minetest.log("lua_object_get_breath")
            minetest.log("lua_object_set_breath #")
            minetest.log("lua_object_get_meta")
            minetest.log("lua_object_get_attribute")
            minetest.log("lua_object_set_attribute #") --Check with Chris
            minetest.log("lua_object_get_fov")
            minetest.log("lua_object_set_fov #")
            minetest.log("lua_object_get_look_dir")
            minetest.log("lua_object_get_look_pitch")
            minetest.log("lua_object_get_look_yaw")
        end
        if param == "5" then
            minetest.log("lua_object_get_look_horizontal")
            minetest.log("lua_object_get_look_vertical")
            minetest.log("lua_object_set_look_pitch #")
            minetest.log("lua_object_set_look_yaw #")
            minetest.log("lua_object_set_look_horizontal #")
            minetest.log("lua_object_set_look_vertical #")
            minetest.log("lua_object_set_sky")
            minetest.log("lua_object_get_sky")
            minetest.log("lua_object_get_sky_color")
            minetest.log("lua_object_get_sun")
        end
        if param == "6" then
            minetest.log("lua_object_get_moon")
            minetest.log("lua_object_set_sun #")
            minetest.log("lua_object_set_moon #")
            minetest.log("lua_object")
            minetest.log("lua_object")
            minetest.log("lua_object")
            minetest.log("lua_object")
            minetest.log("lua_object")
            minetest.log("lua_object")
            minetest.log("lua_object")
        end
    end,
})

-- /*======== LUA FUNCTIONS ========*/

-- l_remove
minetest.register_chatcommand("lua_object_remove", {
    description = "Test Object Remove",
    func = function(name, param)
        if param == "test" then
            param = ""
        end

        minetest.log("lua_object_remove is running!")
        local player = minetest.get_player_by_name(name)
        
        if not player then
            minetest.log("Player not found")
            return
        end

        local pos = player:get_pos()
        local saos = minetest.get_objects_inside_radius(pos, 8)
        
        -- Check if saos is empty
        if #saos == 0 then
            minetest.log("No Active Objects near Player")
            return
        end
        
        -- Output the size of saos to minetest.log
        minetest.log("Size of saos: " .. #saos)

        for i, object in ipairs(saos) do
            if not object:is_player() then
                minetest.log("Removed: "..object:get_entity_name())
                local objectRemove = object:remove()
            end
        end
    end,
})

-- l_get_pos
minetest.register_chatcommand("lua_object_get_pos", {
    description = "Test Object Get Pos",
    func = function(name, param)
        if param == "test" then
            param = ""
        end
        minetest.log("lua_object_get_pos is running!")
        local player = minetest.get_player_by_name(name)
        
        if not player then
            minetest.log("Player not found")
            return
        end

        local pos = player:get_pos()
        local saos = minetest.get_objects_inside_radius(pos, 1)
        
        -- Check if saos is empty
        if #saos == 0 then
            minetest.log("No Active Objects near Player")
            return
        end
        
        -- Output the size of saos to minetest.log
        minetest.log("Size of saos: " .. #saos)
        
        -- Get the position of the first object in saos
        local firstSaosPos = saos[1]:get_pos()
        minetest.log("Position of first Reference Object: " .. minetest.pos_to_string(firstSaosPos))
    end,
})

-- l_set_pos
minetest.register_chatcommand("lua_object_set_pos", {
    description = "Test Object Set Pos - /lua_object_set_pos (Z_Value)",
    func = function(name, param)
        if param == "test" then
            param = "33"
        end
        minetest.log("lua_object_set_pos is running!")
        local player = minetest.get_player_by_name(name)
        
        if not player then
            minetest.log("Player not found")
            return
        end

        local pos = player:get_pos()
        local saos = minetest.get_objects_inside_radius(pos, 1)
        
        -- Check if saos is empty
        if #saos == 0 then
            minetest.log("No Active Objects near Player")
            return
        end
        
        -- Output the size of saos to minetest.log
        minetest.log("Size of Active Objects Array: " .. #saos)

        for i, object in ipairs(saos) do
            -- Check if the object is a player
            if object:is_player() then
                local v3f = {x = 100, y = 22, z = tonumber(param)}
                local player_pos = object:set_pos(v3f)
                minetest.log("Player " .. object:get_player_name() .. " is at position: " .. minetest.pos_to_string(v3f))
            end
        end
    end,
})  

-- l_move_to
minetest.register_chatcommand("lua_object_move_to", {
    description = "Test Object Move To",
    func = function(name, param)
        if param == "test" then
            param = "15"
        end
        minetest.log("lua_object_set_pos is running!")
        local player = minetest.get_player_by_name(name)
        
        if not player then
            minetest.log("Player not found")
            return
        end

        local pos = player:get_pos()
        local saos = minetest.get_objects_inside_radius(pos, 1)
        
        -- Check if saos is empty
        if #saos == 0 then
            minetest.log("No Active Objects near Player")
            return
        end
        
        -- Output the size of saos to minetest.log
        minetest.log("Size of Active Objects Array: " .. #saos)

        for i, object in ipairs(saos) do
            -- Check if the object is a player
            local v3f = {x = 100, y = 22, z = tonumber(param)}
            local player_pos = object:move_to(v3f, false)
            minetest.log(#saos .. " objects moved to position: " .. minetest.pos_to_string(v3f))
        end
    end,
})

-- l_punch
minetest.register_chatcommand("lua_object_punch", {
    description = "Test Object Move To",
    func = function(name, param)
        if param == "test" then
            param = ""
        end
        minetest.log("lua_object_set_pos is running!")
        local player = minetest.get_player_by_name(name)
        
        if not player then
            minetest.log("Player not found")
            return
        end

        local pos = player:get_pos()
        local saos = minetest.get_objects_inside_radius(pos, 2)
        
        -- Check if saos is empty
        if #saos == 0 then
            minetest.log("No Active Objects near Player")
            return
        end
        
        -- Output the size of saos to minetest.log
        minetest.log("Size of Active Objects Array: " .. #saos)

        for i, object in ipairs(saos) do
            -- Check if the object is a player
            if object:is_player() then
                for i, floorobj in ipairs(saos) do
                    if not floorobj:isplayer() then
                        -- Wear all objects on floor
                        -- punch(self, puncher, time_from_last_punch, tool_capabilities, dir)
                        -- object:punch(floorobj, 5, )
                    end
                end
            end
        end
    end,
})

-- l_right_click
-- right_click(self, clicker)
minetest.register_chatcommand("lua_object_right_click", {
    description = "Test Object Right Click",
    func = function(name, param)
        if param == "test" then
            param = ""
        end
        minetest.log("lua_object_right_click is running!")
        local player = minetest.get_player_by_name(name)
        
        if not player then
            minetest.log("Player not found")
            return
        end

        local pos = player:get_pos()
        local saos = minetest.get_objects_inside_radius(pos, 2)
        
        -- Check if saos is empty
        if #saos == 0 then
            minetest.log("No Active Objects near Player")
            return
        end
        
        -- Output the size of saos to minetest.log
        minetest.log("Size of Active Objects Array: " .. #saos)

        -- Insert Lua code here that if saos == 2 then set plyr = saos[0] and rclk = saos[1]
        if #saos == 2 then
            local plyr = saos[1]
            local rclk = saos[2]
            plyr:right_click(rclk)
            minetest.log("Object: "..plyr:get_player_name().." right clicked on ".. rclk:get_entity_name())
        end
    end,
})

--set_hp
minetest.register_chatcommand("lua_object_set_hp", {
    description = "Set the player's current HP - 0-20",
    func = function(name, param)
        if param == "test" then
            param = "12"
        end
        minetest.log("lua_object_et_hp is running!")
        local player = minetest.get_player_by_name(name)
        
        if not player then
            minetest.log("Player not found")
            return
        end

        local pos = player:get_pos()
        local saos = minetest.get_objects_inside_radius(pos, 2)
        
        -- Check if saos is empty
        if #saos == 0 then
            minetest.log("No Active Objects near Player")
            return
        end
        
        -- Output the size of saos to minetest.log
        minetest.log("Size of Active Objects Array: " .. #saos)
        for i, object in ipairs(saos) do
            local a = object:set_hp(tonumber(param), "set_hp")
            minetest.log("The object's HP was set to " ..param)
            minetest.log("The object's HP is currently " ..dump(a))
        end
    end,
})

--get_hp
-- get_hp(self)
minetest.register_chatcommand("lua_object_get_hp", {
    description = "Get the player's current HP",
    func = function(name, param)
        if param == "test" then
            param = ""
        end
        minetest.log("lua_object_get_hp is running!")
        local player = minetest.get_player_by_name(name)
        
        if not player then
            minetest.log("Player not found")
            return
        end

        local pos = player:get_pos()
        local saos = minetest.get_objects_inside_radius(pos, 2)
        
        -- Check if saos is empty
        if #saos == 0 then
            minetest.log("No Active Objects near Player")
            return
        end
        
        -- Output the size of saos to minetest.log
        minetest.log("Size of Active Objects Array: " .. #saos)
        for i, object in ipairs(saos) do
            local a = object:get_hp()
            minetest.log("The object's HP is currently " ..dump(a))
        end
    end,
})

-- get_inventory(self)
minetest.register_chatcommand("lua_object_get_inventory", {
    description = "Check player's inventory and returns inventory functions",
    func = function(name, param)
        if param == "test" then
            param = ""
        end
        minetest.log("lua_object_get_inventory is running!")
        local player = minetest.get_player_by_name(name)
        
        if not player then
            minetest.log("Player not found")
            return
        end

        local pos = player:get_pos()
        local saos = minetest.get_objects_inside_radius(pos, 2)
        
        -- Check if saos is empty
        if #saos == 0 then
            minetest.log("No Active Objects near Player")
            return
        end
        
        -- Output the size of saos to minetest.log
        minetest.log("Size of Active Objects Array: " .. #saos)

        local plyr = saos[1]
        local a = plyr:get_inventory()
        minetest.log(dump(a:get_list("main")))
    end,
})

-- get_weild_list(self)
minetest.register_chatcommand("lua_object_get_wield_list", {
    description = "Get the player's current wield list",
    func = function(name, param)
        if param == "test" then
            param = ""
        end
        minetest.log("lua_object_get_weild_list is running!")
        local player = minetest.get_player_by_name(name)
        
        if not player then
            minetest.log("Player not found")
            return
        end

        local pos = player:get_pos()
        local saos = minetest.get_objects_inside_radius(pos, 2)
        
        -- Check if saos is empty
        if #saos == 0 then
            minetest.log("No Active Objects near Player")
            return
        end
        
        -- Output the size of saos to minetest.log
        minetest.log("Size of Active Objects Array: " .. #saos)

        local plyr = saos[1]
        local a = plyr:get_wield_list()
        minetest.log("The player's wield list is " ..dump(a))
    end,
})

-- get_weild_index(self)
minetest.register_chatcommand("lua_object_get_wield_index", {
    description = "Get the player's current wield index",
    func = function(name, param)
        if param == "test" then
            param = ""
        end
        minetest.log("lua_object_get_weild_index is running!")
        local player = minetest.get_player_by_name(name)
        
        if not player then
            minetest.log("Player not found")
            return
        end

        local pos = player:get_pos()
        local saos = minetest.get_objects_inside_radius(pos, 2)
        
        -- Check if saos is empty
        if #saos == 0 then
            minetest.log("No Active Objects near Player")
            return
        end
        
        -- Output the size of saos to minetest.log
        minetest.log("Size of Active Objects Array: " .. #saos)

        local plyr = saos[1]
        local a = plyr:get_wield_index()
        minetest.log("The player's wield list is " ..dump(a))
    end,
})


-- get_weilded_item(self)
minetest.register_chatcommand("lua_object_get_wielded_item", {
    description = "Get the player's current wielded item",
    func = function(name, param)
        if param == "test" then
            param = ""
        end
        minetest.log("lua_object_get_weilded_item is running!")
        local player = minetest.get_player_by_name(name)
        
        if not player then
            minetest.log("Player not found")
            return
        end

        local pos = player:get_pos()
        local saos = minetest.get_objects_inside_radius(pos, 2)
        
        -- Check if saos is empty
        if #saos == 0 then
            minetest.log("No Active Objects near Player")
            return
        end
        
        -- Output the size of saos to minetest.log
        minetest.log("Size of Active Objects Array: " .. #saos)

        local plyr = saos[1]
        local a = plyr:get_wielded_item()
        minetest.log("The player's wielded item is " ..dump(a))
        minetest.log("The player's wielded item is " ..dump(a:to_string()))
    end,
})


-- Look into
-- set_weilded_item(self)
minetest.register_chatcommand("lua_object_set_wielded_item", {
    description = "Set the player's current wielded item",
    func = function(name, param)
        if param == "test" then
            param = "1"
        end
        minetest.log("lua_object_set_weilded_item is running!")
        local player = minetest.get_player_by_name(name)
        
        if not player then
            minetest.log("Player not found")
            return
        end

        local pos = player:get_pos()
        local saos = minetest.get_objects_inside_radius(pos, 2)
        
        -- Check if saos is empty
        if #saos == 0 then
            minetest.log("No Active Objects near Player")
            return
        end
        
        -- Output the size of saos to minetest.log
        minetest.log("Size of Active Objects Array: " .. #saos)

        local plyr = saos[1]
        if tonumber(param) == 0 then
            local wieldeditem = nil
            local a = plyr:set_wielded_item(wieldeditem)
            minetest.log("The player's wielded item is " ..dump(a))
        elseif tonumber(param) == 1 then
            local wieldeditem = "basetools:sword_stone"
            local a = plyr:set_wielded_item(wieldeditem)
            minetest.log("The player's wielded item is " ..dump(a))
        else
            minetest.log("input a param: \n 0 - null \n 1 - stone sword")
        end
    end,
})


--Skip set armor (fleshy, crumbly, cracky)

-- get_armor_groups(self)
minetest.register_chatcommand("lua_object_get_armor_groups", {
    description = "Get the player's current armor groups",
    func = function(name, param)
        if param == "test" then
            param = ""
        end
        minetest.log("lua_object_get_weilded_item is running!")
        local player = minetest.get_player_by_name(name)
        
        if not player then
            minetest.log("Player not found")
            return
        end

        local pos = player:get_pos()
        local saos = minetest.get_objects_inside_radius(pos, 2)
        
        -- Check if saos is empty
        if #saos == 0 then
            minetest.log("No Active Objects near Player")
            return
        end
        
        -- Output the size of saos to minetest.log
        minetest.log("Size of Active Objects Array: " .. #saos)

        local plyr = saos[1]
        local a = plyr:get_armor_groups()
        local b = player:get_armor_groups()
        -- minetest.log("The player's armor group information is " ..dump(a:to_string()))
        minetest.log("The player's armor group information is " ..dump(a))
        minetest.log("The player's armor group information is " ..dump(b))
    end,
})


-- set_animation(self, frame_range, frame_speed, frame_blend, frame_loop)
-- get_animation(self)
minetest.register_chatcommand("lua_object_get_animation", {
    description = "Get the object's animation",
    func = function(name, param)
        if param == "test" then
            param = ""
        end
        minetest.log("lua_object_get_animation is running!")
        local player = minetest.get_player_by_name(name)
        
        if not player then
            minetest.log("Player not found")
            return
        end

        local pos = player:get_pos()
        local saos = minetest.get_objects_inside_radius(pos, 2)
        
        -- Check if saos is empty
        if #saos == 0 then
            minetest.log("No Active Objects near Player")
            return
        end
        
        -- Output the size of saos to minetest.log
        minetest.log("Size of Active Objects Array: " .. #saos)

        if #saos == 2 then
            -- local plyr = saos[1]
            local rclk = saos[2]
            local a = rclk:get_animation()
            minetest.log("The Current animation information for ".. rclk:get_entity_name().." is "..dump(a))
        else
            local plyr = saos[1]
            local a = plyr:get_animation()
            minetest.log("The Current animation information for ".. plyr:get_player_name() .." is "..dump(a))
        end
    end,
})
-- set_local_animation(self, idle, walk, dig, walk_while_dog, frame_speed)
-- get_local_animation(self)
minetest.register_chatcommand("lua_object_get_local_animation", {
    description = "Get the player's animation",
    func = function(name, param)
        if param == "test" then
            param = ""
        end
        minetest.log("lua_object_get_local_animation_item is running!")
        local player = minetest.get_player_by_name(name)
        
        if not player then
            minetest.log("Player not found")
            return
        end

        local pos = player:get_pos()
        local saos = minetest.get_objects_inside_radius(pos, 2)
        
        -- Check if saos is empty
        if #saos == 0 then
            minetest.log("No Active Objects near Player")
            return
        end
        
        -- Output the size of saos to minetest.log
        minetest.log("Size of Active Objects Array: " .. #saos)


        local plyr = saos[1]
        local a = plyr:get_local_animation()
        minetest.log("The Current animation information for ".. plyr:get_player_name() .." is "..dump(a))
    end,
})

-- get_eye_offset(self)
minetest.register_chatcommand("lua_object_get_eye_offset", {
    description = "Get the player's current eye offset",
    func = function(name, param)
        if param == "test" then
            param = ""
        end
        minetest.log("lua_object_get_eye_offset is running!")
        local player = minetest.get_player_by_name(name)
        
        if not player then
            minetest.log("Player not found")
            return
        end

        local pos = player:get_pos()
        local saos = minetest.get_objects_inside_radius(pos, 2)
        
        -- Check if saos is empty
        if #saos == 0 then
            minetest.log("No Active Objects near Player")
            return
        end
        
        -- Output the size of saos to minetest.log
        minetest.log("Size of Active Objects Array: " .. #saos)

        local plyr = saos[1]
        local a = plyr:get_eye_offset()
        --local b = player:get_armor_groups()
        -- minetest.log("The player's armor group information is " ..dump(a:to_string()))
        minetest.log("The player's eye offset is " ..dump(a))

    end,
})


-- set_eye_offset(self)
minetest.register_chatcommand("lua_object_set_eye_offset", {
    description = "Set the player's current eye offset",
    func = function(name, param)
        if param == "test" then
            param = "14"
        end
        minetest.log("lua_object_get_eye_offset is running!")
        local player = minetest.get_player_by_name(name)
        
        if not player then
            minetest.log("Player not found")
            return
        end

        local pos = player:get_pos()
        local saos = minetest.get_objects_inside_radius(pos, 2)
        
        -- Check if saos is empty
        if #saos == 0 then
            minetest.log("No Active Objects near Player")
            return
        end
        
        -- Output the size of saos to minetest.log
        minetest.log("Size of Active Objects Array: " .. #saos)

        local plyr = saos[1]
        if param ~= "" then
            local v3f = {x = 0, y = tonumber(param), z = 0}
            local a = plyr:set_eye_offset(v3f)
            minetest.log("The player's eye offset is now" ..dump(v3f))
        else
            local v3f = {x = 0, y = 0, z = 0}
            local a = plyr:set_eye_offset(v3f)
            minetest.log("lua_object_set_eye_offset # (0 is default)")
        end
    end,
})


-- send_mapblock(self, pos)
-- Figure out how to trigger it
minetest.register_chatcommand("lua_object_send_mapblock", {
    description = "Sends an already loaded mapblock to the player.\nReturns false if nothing was sent (note that this can also mean that the client already has the block)\nResource intensive - use sparsely",
    func = function(name, param)
        if param == "test" then
            param = ""
        end
        minetest.log("Sends an already loaded mapblock to the player.\nReturns false if nothing was sent (note that this can also mean that the client already has the block)\nResource intensive - use sparsely")
        local player = minetest.get_player_by_name(name)
        
        if not player then
            minetest.log("Player not found")
            return
        end

        local pos = player:get_pos()
        local saos = minetest.get_objects_inside_radius(pos, 2)
        
        -- Check if saos is empty
        if #saos == 0 then
            minetest.log("No Active Objects near Player")
            return
        end
        
        -- Output the size of saos to minetest.log
        minetest.log("Size of Active Objects Array: " .. #saos)

        local plyr = saos[1]
        local a = plyr:send_mapblock(pos)
        --local b = player:get_armor_groups()
        -- minetest.log("The player's armor group information is " ..dump(a:to_string()))
        if a then
            minetest.log("Mapblock was sent to player. Responce:  " ..dump(a))
        else 
            minetest.log("Mapblock was NOT sent to player. Responce:  " ..dump(a))
        end
    end,
})


--set_animation_frame_speed(self, frame_speed)

--set_bone_position(self, bone, position, rotation)

--get_bone_position(self, bone)

--set_attach(self, parent, bone, position, rotation, force_visable)

--get_attach(self)

--get_children(self)

--set_detach(self)

--set_properties(self, properties)

--get_properties(self)

--is_player(self) Used in most functions

--set_nametag_attributes

-- Chris Functions
-- l_set_breath
minetest.register_chatcommand("lua_object_set_breath", {
    description = "Test Set Breath - /lua_object_set_breath (breath_value)",
    func = function(name, param)
        if param == "test" then
            param = "1"
        end
        minetest.log("lua_object_set_breath is running!")
        local player = minetest.get_player_by_name(name)

        if not player then
            minetest.log("Player not found")
            return
        end

        local breath_value = tonumber(param)
        if not breath_value then
            minetest.log("Invalid breath value")
            return
        end

        player:set_breath(breath_value)
        minetest.log("Player breath set to: " .. breath_value)
    end,
})

-- l_get_breath
minetest.register_chatcommand("lua_object_get_breath", {
    description = "Test Get Breath",
    func = function(name, param)
        if param == "test" then
            param = ""
        end
        minetest.log("lua_object_get_breath is running!")
        local player = minetest.get_player_by_name(name)

        if not player then
            minetest.log("Player not found")
            return
        end

        local breath = player:get_breath()
        minetest.log("Player's current breath: " .. breath)
    end,
})

-- l_set_fov
minetest.register_chatcommand("lua_object_set_fov", {
    description = "Test Set FOV - /lua_object_set_fov (degrees) (is_multiplier) (transition_time)",
    func = function(name, param)
        if param == "test" then
            param = "90 false 1"
        end
        minetest.log("lua_object_set_fov is running!")
        local player = minetest.get_player_by_name(name)

        if not player then
            minetest.log("Player not found")
            return
        end
        
        local degrees, is_multiplier, transition_time = string.match(param, "^(%-?%d+%.?%d*) (%a+) (%d+%.?%d*)$")
        degrees = tonumber(degrees)
        transition_time = tonumber(transition_time)
        is_multiplier = is_multiplier == "true"
        
        if not degrees or is_multiplier == nil or not transition_time then
            minetest.log("Invalid FOV values")
            return
        end
        
        player:set_fov(degrees, is_multiplier, transition_time)
        minetest.log("Player FOV set to: degrees: " .. degrees .. " is_multiplier: " .. tostring(is_multiplier) .. " transition_time: " .. transition_time)
    end,
})

-- l_get_fov
minetest.register_chatcommand("lua_object_get_fov", {
    description = "Test Get FOV",
    func = function(name, param)
        if param == "test" then
            param = ""
        end
        minetest.log("lua_object_get_fov is running!")
        local player = minetest.get_player_by_name(name)
        
        if not player then
            minetest.log("Player not found")
            return
        end
        
        local degrees, is_multiplier, transition_time = player:get_fov()
        minetest.log("Player's current FOV: degrees: " .. degrees .. " is_multiplier: " .. tostring(is_multiplier) .. " transition_time: " .. transition_time)
    end,
})

-- l_set_attribute
minetest.register_chatcommand("lua_object_set_attribute", {
    description = "Test Set Attribute - /lua_object_set_attribute (attribute) (value)",
    func = function(name, param)
        if param == "test" then
            param = "breath 10"
        end
        minetest.log("lua_object_set_attribute is running!")
        local player = minetest.get_player_by_name(name)
        
        if not player then
            minetest.log("Player not found")
            return
        end
        
        local attribute, value = string.match(param, "^([^ ]+) (.+)$")
        
        if not attribute or not value then
            minetest.log("Invalid attribute or value")
            return
        end
        
        player:set_attribute(attribute, value)
        minetest.log("Player " .. attribute .. " set to: " .. value)
    end,
})

-- l_get_attribute
minetest.register_chatcommand("lua_object_get_attribute", {
    description = "Test Get Attribute - /lua_object_get_attribute (attribute)",
    func = function(name, param)
        if param == "test" then
            param = "breath"
        end
        minetest.log("lua_object_get_attribute is running!")
        local player = minetest.get_player_by_name(name)
        
        if not player then
            minetest.log("Player not found")
            return
        end
        
        local attribute = param
        
        if not attribute then
            minetest.log("Invalid attribute")
            return
        end
        
        local value = player:get_attribute(attribute)
        minetest.log("Player's " .. attribute .. ": " .. (value or "nil"))
    end,
})

-- l_get_meta
minetest.register_chatcommand("lua_object_get_meta", {
    description = "Test Get Meta",
    func = function(name, param)
        if param == "test" then
            param = ""
        end
        minetest.log("lua_object_get_meta is running!")
        local player = minetest.get_player_by_name(name)
        
        if not player then
            minetest.log("Player not found")
            return
        end
        
        local meta = player:get_meta()
        
        if meta then
            minetest.log("Player Meta Retrieved")
        else
            minetest.log("Failed to Retrieve Player Meta")
        end
    end,
})


-- l_get_look_dir
minetest.register_chatcommand("lua_object_get_look_dir", {
    description = "Test Look Direction",
    func = function(name, param)
        if param == "test" then
            param = ""
        end
        minetest.log("lua_object_get_look_dir is running!")
        local player = minetest.get_player_by_name(name)

        if not player then
            minetest.log("Player not found")
            return
        end

        local look_dir = player:get_look_dir()
        minetest.log("Player's look direction (Lua): " .. minetest.pos_to_string(look_dir))
    end,
})



-- DEPRECATED: l_get_look_pitch
minetest.register_chatcommand("lua_object_get_look_pitch", {
    description = "Test Deprecated Get Look Pitch",
    func = function(name, param)
        if param == "test" then
            param = ""
        end
        minetest.log("lua_object_get_look_pitch is running!")
        local player = minetest.get_player_by_name(name)
        if not player then
            minetest.log("Player not found")
            return
        end

        local look_pitch = player:get_look_pitch()
        minetest.log("Deprecated Look Pitch: " .. look_pitch)
    end,
})

-- DEPRECATED: l_get_look_yaw
minetest.register_chatcommand("lua_object_get_look_yaw", {
    description = "Test Deprecated Get Look Yaw",
    func = function(name, param)
        if param == "test" then
            param = ""
        end
        minetest.log("lua_object_get_look_yaw is running!")
        local player = minetest.get_player_by_name(name)
        if not player then
            minetest.log("Player not found")
            return
        end

        local look_yaw = player:get_look_yaw()
        minetest.log("Deprecated Look Yaw: " .. look_yaw)
    end,
})

-- l_get_look_vertical
minetest.register_chatcommand("lua_object_get_look_vertical", {
    description = "Test Get Look Vertical",
    func = function(name, param)
        if param == "test" then
            param = ""
        end
        minetest.log("lua_object_get_look_vertical is running!")
        local player = minetest.get_player_by_name(name)
        if not player then
            minetest.log("Player not found")
            return
        end

        local look_vertical = player:get_look_vertical()
        minetest.log("Look Vertical: " .. look_vertical)
    end,
})

-- l_get_look_horizontal
minetest.register_chatcommand("lua_object_get_look_horizontal", {
    description = "Test Get Look Horizontal",
    func = function(name, param)
        if param == "test" then
            param = ""
        end
        minetest.log("lua_object_get_look_horizontal is running!")
        local player = minetest.get_player_by_name(name)
        if not player then
            minetest.log("Player not found")
            return
        end

        local look_horizontal = player:get_look_horizontal()
        minetest.log("Look Horizontal: " .. look_horizontal)
    end,
})



-- Lua l_set_look_vertical
minetest.register_chatcommand("lua_object_set_look_vertical", {
    description = "Test Lua Set Look Vertical - /lua_object_set_look_vertical (radians)",
    func = function(name, param)
        if param == "test" then
            param = "20"
        end
        local player = minetest.get_player_by_name(name)
        if not player then
            minetest.log("Player not found")
            return
        end

        local radians = tonumber(param)
        if not radians then
            minetest.log("Invalid radian value")
            return
        end

        player:set_look_vertical(radians)
    end,
})

-- Lua l_set_look_horizontal
minetest.register_chatcommand("lua_object_set_look_horizontal", {
    description = "Test Lua Set Look Horizontal - /lua_object_set_look_horizontal (radians)",
    func = function(name, param)
        if param == "test" then
            param = "20"
        end
        local player = minetest.get_player_by_name(name)
        if not player then
            minetest.log("Player not found")
            return
        end

        local radians = tonumber(param)
        if not radians then
            minetest.log("Invalid radian value")
            return
        end

        player:set_look_horizontal(radians)
    end,
})

-- DEPRECATED: Lua l_set_look_pitch
minetest.register_chatcommand("lua_object_set_look_pitch", {
    description = "Test (Deprecated) Lua Set Look Pitch - /lua_object_set_look_pitch (radians)",
    func = function(name, param)
        if param == "test" then
            param = "20"
        end
        local player = minetest.get_player_by_name(name)
        if not player then
            minetest.log("Player not found")
            return
        end

        local radians = tonumber(param)
        if not radians then
            minetest.log("Invalid radian value")
            return
        end

        player:set_look_pitch(radians)
    end,
})

-- DEPRECATED: Lua l_set_look_yaw
minetest.register_chatcommand("lua_object_set_look_yaw", {
    description = "Test (Deprecated) Lua Set Look Yaw - /lua_object_set_look_yaw (radians)",
    func = function(name, param)
        if param == "test" then
            param = "20"
        end
        local player = minetest.get_player_by_name(name)
        if not player then
            minetest.log("Player not found")
            return
        end

        local radians = tonumber(param)
        if not radians then
            minetest.log("Invalid radian value")
            return
        end

        player:set_look_yaw(radians)
    end,
})



-- Lua Testing for set_sky (Skip)
minetest.register_chatcommand("lua_object_set_sky", {
    description = "Set Sky Parameters",
    func = function(name, param)
        if param == "test" then
            param = ""
        end
        local player = minetest.get_player_by_name(name)
        if not player then
            minetest.log("Player not found!")
            return
        end
        -- Example sky parameters, you can modify as needed
        local sky_parameters = {
            base_color = "#ABCDEF",
            type = "regular",
            textures = {"sky_texture_1.png", "sky_texture_2.png", },
            clouds = true,
            sky_color = {
                day_sky = "#ABCDEF",
                day_horizon = "#ABCDEF",
                dawn_sky = "#ABCDEF",
                dawn_horizon = "#ABCDEF",
                night_sky = "#ABCDEF",
                night_horizon = "#ABCDEF",
                indoors = "#ABCDEF"
            }
        }
        player:set_sky(sky_parameters)
        minetest.log("Sky parameters set for player: " .. name)
    end
})

-- Lua Testing for get_sky
minetest.register_chatcommand("lua_object_get_sky", {
    description = "Retrieve Sky Parameters",
    func = function(name, param)
        if param == "test" then
            param = ""
        end
        local player = minetest.get_player_by_name(name)
        if not player then
            minetest.log("Player not found!")
            return
        end
        local sky = player:get_sky()
        -- Here you can process and display the 'sky' data as needed
        minetest.log(dump(sky))
    end
})


-- Lua Testing for get_sky_color
minetest.register_chatcommand("lua_object_get_sky_color", {
    description = "Retrieve Sky Colors",
    func = function(name, param)
        if param == "test" then
            param = ""
        end
        local player = minetest.get_player_by_name(name)
        if not player then
            minetest.log("Player not found!")
            return
        end
        local sky_color = player:get_sky_color()
        -- Here you can process and display the 'sky_color' data as needed
        minetest.log(dump(sky_color))
    end
})

-- Lua Testing for set_sun
minetest.register_chatcommand("lua_object_set_sun", {
    description = "Test set_sun - /lua_object_set_sun",
    func = function(name, param)
        if param == "test" then
            param = ""
        end
        local player = minetest.get_player_by_name(name)
        if not player then
            return false, "Player not found"
        end

        local sun_params = {
            visible = true,
            texture = "some_texture.png",
            tonemap = "some_tonemap.png",
            sunrise = "some_sunrise.png",
            sunrise_visible = true,
            scale = 1.0
        }
        player:set_sun(sun_params)
        return true, "Sun parameters set using lua_object_set_sun"
    end,
})

-- Lua Testing for get_sun
minetest.register_chatcommand("lua_object_get_sun", {
    description = "Test get_sun - /lua_object_get_sun",
    func = function(name, _)
        local player = minetest.get_player_by_name(name)
        if not player then
            return false, "Player not found"
        end

        local sun_params = player:get_sun()
        -- Here, you can either print the parameters or use them further
        return true, "Got sun parameters using lua_object_get_sun"
    end,
})

-- Lua Testing for set_moon
minetest.register_chatcommand("lua_object_set_moon", {
    description = "Test set_moon - /lua_object_set_moon",
    func = function(name, param)
        if param == "test" then
            param = ""
        end
        local player = minetest.get_player_by_name(name)
        if not player then
            return false, "Player not found"
        end

        local moon_params = {
            visible = true,
            texture = "some_moon_texture.png",
            tonemap = "some_moon_tonemap.png",
            scale = 1.0
        }
        player:set_moon(moon_params)
        return true, "Moon parameters set using lua_object_set_moon"
    end,
})

-- Lua Testing for get_moon
minetest.register_chatcommand("lua_object_get_moon", {
    description = "Test get_moon - /lua_object_get_moon",
    func = function(name, _)
        local player = minetest.get_player_by_name(name)
        if not player then
            return false, "Player not found"
        end

        local moon_params = player:get_moon()
        -- Here, you can either print the parameters or use them further
        return true, "Got moon parameters using lua_object_get_moon"
    end,
})


-- Lua Testing for set_stars
minetest.register_chatcommand("lua_object_set_stars", {
    description = "Test Set Stars",
    func = function(name, param)
        if param == "test" then
            param = "1 {visible=true, count=1000, star_color={a=255, r=255, g=255, b=255}, scale=1.0}"
        end
        local player = minetest.get_player_by_name(name)
        if not player then
            minetest.log("Player not found")
            return
        end
        player:set_stars({
            visible = true,
            count = 500,
            star_color = {a=255, r=255, g=255, b=255},
            scale = 1.0
        })
        minetest.log("Stars set for player: " .. name)
    end,
})

-- Lua Testing for get_stars
minetest.register_chatcommand("lua_object_get_stars", {
    description = "Test Get Stars",
    func = function(name, param)
        if param == "test" then
            param = ""
        end
        local player = minetest.get_player_by_name(name)
        if not player then
            minetest.log("Player not found")
            return
        end
        local stars = player:get_stars()
        minetest.log(dump(stars))
    end,
})

-- Lua Testing for set_clouds
minetest.register_chatcommand("lua_object_set_clouds", {
    description = "Test Set Clouds",
    func = function(name, param)
        if param == "test" then
            param = "1 {density=0.5, color={a=255, r=255, g=255, b=255}, ambient={a=255, r=255, g=255, b=255}, height=120, thickness=16, speed={x=0, y=0}}"
        end
        local player = minetest.get_player_by_name(name)
        if not player then
            minetest.log("Player not found")
            return
        end
        player:set_clouds({
            density = 0.6,
            color = {a=255, r=255, g=255, b=255},
            ambient = {a=255, r=128, g=128, b=128},
            height = 120,
            thickness = 16,
            speed = {x=0, y=2}
        })
        minetest.log("Clouds set for player: " .. name)
    end,
})

-- Lua Testing for get_clouds
minetest.register_chatcommand("lua_object_get_clouds", {
    description = "Test Get Clouds",
    func = function(name, param)
        if param == "test" then
            param = ""
        end
        local player = minetest.get_player_by_name(name)
        if not player then
            minetest.log("Player not found")
            return
        end
        local clouds = player:get_clouds()
        minetest.log(dump(clouds))
    end,
})

-- Test l_get_entity_name Function
minetest.register_chatcommand("lua_object_get_entity_name", {
    description = "Test Get Entity Name",
    func = function(name, param)
        if param == "test" then
            param = ""
        end
        minetest.log("Testing l_get_entity_name...")
        local player = minetest.get_player_by_name(name)
        
        if not player then
            minetest.log("Player not found")
            return
        end

        local saos = minetest.get_objects_inside_radius(player:get_pos(), 8)
        
        for i, object in ipairs(saos) do
            if not object:is_player() then
                local entityName = object:get_entity_name()
                minetest.log("Entity Name: " .. entityName)
            end
        end
    end,
})

-- Test l_get_player_name Function
minetest.register_chatcommand("lua_object_get_player_name", {
    description = "Test Get Player Name",
    func = function(name, param)
        if param == "test" then
            param = ""
        end
        local player = minetest.get_player_by_name(name)
        if player then
            minetest.log("Player Name: " .. player:get_player_name())
        else
            minetest.log("Player not found")
        end
    end,
})

-- Test l_get_luaentity Function
minetest.register_chatcommand("lua_object_get_luaentity", {
    description = "Test LuaEntity",
    func = function(name, param)
        if param == "test" then
            param = ""
        end
        minetest.log("Testing l_get_luaentity...")
        local player = minetest.get_player_by_name(name)
        
        if not player then
            minetest.log("Player not found")
            return
        end

        local saos = minetest.get_objects_inside_radius(player:get_pos(), 8)
        
        for i, object in ipairs(saos) do
            if not object:is_player() then
                local luaEntity = object:get_luaentity()
                minetest.log("LuaEntity ID: " .. (luaEntity and luaEntity:get_id() or "nil"))
            end
        end
    end,
})


-- Lua Testing for override_day_night_ratio
minetest.register_chatcommand("lua_object_override_day_night_ratio", {
    description = "Lua Test Override Day Night Ratio",
    func = function(name, param)
        if param == "test" then
            param = "0.5"
        end
        local player = minetest.get_player_by_name(name)
        if not player then
            minetest.log("Player not found")
            return
        end
        local ratio = tonumber(param) or 0.5
        player:override_day_night_ratio(ratio)
        minetest.log("Day Night Ratio (Lua) set to: " .. ratio .. " for player: " .. name)
    end,
})

-- Lua Testing for get_day_night_ratio
minetest.register_chatcommand("lua_object_get_day_night_ratio", {
    description = "Lua Test Get Day Night Ratio",
    func = function(name, param)
        if param == "test" then
            param = ""
        end
        local player = minetest.get_player_by_name(name)
        if not player then
            minetest.log("Player not found")
            return
        end
        local ratio = player:get_day_night_ratio()
        minetest.log("Day Night Ratio (Lua) for player " .. name .. " is: " .. (ratio or "Not set"))
    end,
})

-- Lua Testing for hud_set_hotbar_itemcount
minetest.register_chatcommand("lua_object_hud_set_hotbar_itemcount", {
    description = "Lua Test Set Hotbar Item Count",
    func = function(name, param)
        if param == "test" then
            param = "100"
        end
        local player = minetest.get_player_by_name(name)
        if not player then
            minetest.log("Player not found")
            return
        end

        player:hud_set_hotbar_itemcount(tonumber(param) or 8) -- default to 8 if no input
    end,
})

-- Lua Testing for hud_get_hotbar_itemcount
minetest.register_chatcommand("lua_object_hud_get_hotbar_itemcount", {
    description = "Lua Test Get Hotbar Item Count",
    func = function(name, param)
        if param == "test" then
            param = ""
        end
        local player = minetest.get_player_by_name(name)
        if not player then
            return "Player not found"
        end

        local count = player:hud_get_hotbar_itemcount()
        return true, "Hotbar Item Count: " .. count
    end,
})

-- Lua Testing for hud_set_hotbar_image
minetest.register_chatcommand("lua_object_hud_set_hotbar_image", {
    description = "Lua Test Set Hotbar Image",
    func = function(name, param)
        if param == "test" then
            param = ""
        end
        local player = minetest.get_player_by_name(name)
        if not player then
            minetest.log("Player not found")
            return
        end

        player:hud_set_hotbar_image(param) -- set to the provided image name
    end,
})

-- Lua Testing for hud_get_hotbar_image
minetest.register_chatcommand("lua_object_hud_get_hotbar_image", {
    description = "Lua Test Get Hotbar Image",
    func = function(name, param)
        if param == "test" then
            param = ""
        end
        local player = minetest.get_player_by_name(name)
        if not player then
            return "Player not found"
        end

        local image = player:hud_get_hotbar_image()
        return true, "Hotbar Image: " .. image
    end,
})

-- Lua Testing for hud_add
minetest.register_chatcommand("lua_object_hud_add", {
    description = "Test the hud_add function",
    func = function(name)
        if param == "test" then
            param = "1"
        end
        local player = minetest.get_player_by_name(name)
        if not player then
            return false, "Player not found"
        end
        
        local hud_def = {
            hud_elem_type = "image",
            position = {x = 0.5, y = 0.5},
            offset = {x = 0, y = 0},
            text = "default_wood.png",
            scale = {x = 2, y = 2},
            alignment = {x = 0, y = 0},
        }
        local id = player:hud_add(hud_def)
        
        if id then
            minetest.chat_send_player(name, "HUD element added with ID: " .. id)
            return true
        else
            return false, "Failed to add HUD element"
        end
    end,
})


-- Lua Testing for hud_remove
minetest.register_chatcommand("lua_object_hud_remove", {
    description = "Test the hud_remove function",
    func = function(name, param)
        if param == "test" then
            param = "1"
        end
        local player = minetest.get_player_by_name(name)
        if not player then
            return false, "Player not found"
        end

        local id = tonumber(param)
        if not id then
            return false, "Invalid HUD ID"
        end
        
        local success = player:hud_remove(id)
        return success, success and "HUD element removed." or "Failed to remove HUD element."
    end,
})


-- Lua Testing for hud_change
minetest.register_chatcommand("lua_object_hud_change", {
    description = "Test the hud_change function",
    func = function(name, param)
        if param == "test" then
            param = ""
        end
        local player = minetest.get_player_by_name(name)
        if not player then
            return false, "Player not found"
        end

        local id, stat, data = parse_hud_change_parameters(param)
        if not id then
            return false, "Invalid parameters"
        end
        
        player:hud_change(id, stat, data)
        return true, "HUD element changed."
    end,
})


-- Lua Testing for hud_change
minetest.register_chatcommand("lua_object_hud_change", {
    description = "Test the hud_change function",
    func = function(name, param)
        if param == "test" then
            param = ""
        end
        local player = minetest.get_player_by_name(name)
        if not player then
            return false, "Player not found"
        end

        local id, stat, data = parse_hud_change_parameters(param)
        if not id then
            return false, "Invalid parameters"
        end
        
        player:hud_change(id, stat, data)
        return true, "HUD element changed."
    end,
})



-- Lua Testing for hud_set_flags
minetest.register_chatcommand("lua_object_hud_set_flags", {
    description = "Test the hud_set_flags function",
    func = function(name)
        if param == "test" then
            param = ""
        end
        local player = minetest.get_player_by_name(name)
        if not player then
            return false, "Player not found"
        end
        
        local flags = {
            hotbar = false,
            healthbar = false,
            crosshair = true,
            wielditem = true,
            breathbar = false,
            minimap = true,
            minimap_radar = true,
        }
        
        local success = player:hud_set_flags(flags)
        return success, success and "HUD flags set." or "Failed to set HUD flags."
    end,
})



-- Lua Testing for hud_get_flags
minetest.register_chatcommand("lua_object_hud_get_flags", {
    description = "Test the hud_get_flags function",
    func = function(name)
        if param == "test" then
            param = ""
        end
        local player = minetest.get_player_by_name(name)
        if not player then
            return false, "Player not found"
        end
        
        local flags = player:hud_get_flags()
        if flags then
            -- serialize or use the flags for assertion
            return true, minetest.serialize(flags)
        else
            return false, "Failed to get HUD flags."
        end
    end,
})


-- Lua Testing for hud_set_hotbar_selected_image
minetest.register_chatcommand("lua_object_set_hotbar_selected_image", {
    description = "Test the hud_set_hotbar_selected_image function",
    func = function(name, param)
        if param == "test" then
            param = "1"
        end
        local player = minetest.get_player_by_name(name)
        if not player then
            return false, "Player not found"
        end

        if param and param ~= "" then
            player:hud_set_hotbar_selected_image(param)
            return true, "Hotbar selected image set to " .. param
        else
            return false, "Invalid image name"
        end
    end,
})


-- Lua Testing for hud_get_hotbar_selected_image
minetest.register_chatcommand("lua_object_get_hotbar_selected_image", {
    description = "Test the hud_get_hotbar_selected_image function",
    func = function(name)
        if param == "test" then
            param = ""
        end
        local player = minetest.get_player_by_name(name)
        if not player then
            return false, "Player not found"
        end

        local image_name = player:hud_get_hotbar_selected_image()
        if image_name then
            return true, "Hotbar selected image is: " .. image_name
        else
            return false, "Failed to get hotbar selected image"
        end
    end,
})


-- Lua Testing for set_yaw
minetest.register_chatcommand("lua_object_set_yaw", {
    description = "Test the set_yaw function",
    params = "<yaw>",
    func = function(name, param)
        if param == "test" then
            param = "20"
        end
        local player = minetest.get_player_by_name(name)
        if not player then
            return false, "Player not found"
        end

        local yaw = tonumber(param)
        if not yaw then
            return false, "Invalid yaw value"
        end
        
        player:set_yaw(yaw)
        return true, "Yaw set to " .. yaw
    end,
})


-- Lua Testing for get_yaw
minetest.register_chatcommand("lua_object_get_yaw", {
    description = "Test the get_yaw function",
    func = function(name)
        if param == "test" then
            param = ""
        end
        local player = minetest.get_player_by_name(name)
        if not player then
            return false, "Player not found"
        end

        local yaw = player:get_yaw()
        return true, "Current yaw: " .. yaw
    end,
})


-- Lua Testing for set_texture_mod
minetest.register_chatcommand("lua_object_set_texture_mod", {
    description = "Test the set_texture_mod function",
    params = "<mod>",
    func = function(name, param)
        if param == "test" then
            param = ""
        end
        local player = minetest.get_player_by_name(name)
        if not player then
            return false, "Player not found"
        end

        player:set_texture_mod(param)
        return true, "Texture mod set to " .. param
    end,
})


-- Lua Testing for get_texture_mod
minetest.register_chatcommand("lua_object_get_texture_mod", {
    description = "Test the get_texture_mod function",
    func = function(name)
        local player = minetest.get_player_by_name(name)
        if not player then
            return false, "Player not found"
        end

        local mod = player:get_texture_mod()
        return true, "Current texture mod: " .. mod
    end,
})

-- Lua Testing for set_sprite
minetest.register_chatcommand("lua_object_set_sprite", {
    description = "Test the set_sprite function",
    params = "<start_frame> <num_frames> <framelength> <select_x_by_camera>",
    func = function(name, param)
        if param == "test" then
            param = ""
        end
        local start_frame, num_frames, framelength, select_x_by_camera =
            param:match("^(%d+)%s+(%d+)%s+(%f+)%s+(%a+)$")

        if not (start_frame and num_frames and framelength and select_x_by_camera) then
            return false, "Invalid parameters. Provide start_frame, num_frames, framelength, select_x_by_camera."
        end

        start_frame = tonumber(start_frame)
        num_frames = tonumber(num_frames)
        framelength = tonumber(framelength)
        select_x_by_camera = select_x_by_camera == "true"

        local player = minetest.get_player_by_name(name)
        if not player then
            return false, "Player not found"
        end

        -- Assuming set_sprite function exists and works as follows:
        player:set_sprite({x=start_frame, y=0}, num_frames, framelength, select_x_by_camera)
        return true, "Sprite set successfully"
    end,
})

minetest.register_chatcommand("lua_object_set_bone_position", {
    description = "Test the set_bone_position function",
    params = "<bone> <position> <rotation>",
    func = function(name, param)
        if param == "test" then
            param = "arm (0,1,0) (0,90,0)"
        end
        local bone, pos_str, rot_str = param:match("^(%S+)%s+(%S+)%s+(%S+)$")
        local position = minetest.string_to_pos(pos_str)
        local rotation = minetest.string_to_pos(rot_str)
        if not bone or not position or not rotation then
            return false, "Invalid parameters (expected: 'bone position rotation')"
        end
        
        local player = minetest.get_player_by_name(name)
        if not player then
            return false, "Player not found"
        end

        player:set_bone_position(bone, position, rotation)
        return true, "Bone position set for " .. bone
    end,
})

minetest.register_chatcommand("lua_object_get_bone_position", {
    description = "Test the get_bone_position function",
    params = "<bone>",
    func = function(name, bone)
        if param == "test" then
            param = "arm"
        end
        local player = minetest.get_player_by_name(name)
        if not player then
            return false, "Player not found"
        end

        local position, rotation = player:get_bone_position(bone)
        if not position then
            return false, "Bone not found or player not available"
        end
        
        local pos_str = minetest.pos_to_string(position)
        local rot_str = minetest.pos_to_string(rotation)
        return true, "Bone position for " .. bone .. ": pos=" .. pos_str .. " rot=" .. rot_str
    end,
})

minetest.register_chatcommand("lua_object_set_attach", {
    description = "Test the set_attach function",
    params = "<parent> <bone> <position> <rotation> <force_visible>",
    func = function(name, param)
        if param == "test" then
            param = "other_player_name arm (0,1,0) (0,0,0) true"
        end
        local parent_name, bone, pos_str, rot_str, force_visible_str = param:match("^(%S+)%s+(%S+)%s+(%S+)%s+(%S+)%s+(%S+)$")
        local position = minetest.string_to_pos(pos_str)
        local rotation = minetest.string_to_pos(rot_str)
        local force_visible = force_visible_str == "true"
        local parent = minetest.get_player_by_name(parent_name)
        local player = minetest.get_player_by_name(name)
        if not player or not parent then
            return false, "Player or parent not found"
        end

        player:set_attach(parent, bone, position, rotation, force_visible)
        return true, "Player attached to " .. parent_name
    end,
})

minetest.register_chatcommand("lua_object_get_attach", {
    description = "Test the get_attach function",
    func = function(name)
        if param == "test" then
            param = ""
        end
        local player = minetest.get_player_by_name(name)
        if not player then
            return false, "Player not found"
        end

        local parent, bone, position, rotation, force_visible = player:get_attach()
        if not parent then
            return false, "Player is not attached"
        end

        local pos_str = minetest.pos_to_string(position)
        local rot_str = minetest.pos_to_string(rotation)
        return true, "Player attached to " .. parent:get_player_name() .. " at bone " .. bone .. " with position " .. pos_str .. " and rotation " .. rot_str
    end,
})

minetest.register_chatcommand("lua_object_get_children", {
    description = "Test the get_children function",
    func = function(name)
        if param == "test" then
            param = ""
        end
        local player = minetest.get_player_by_name(name)
        if not player then
            return false, "Player not found"
        end

        local children = player:get_children()
        if not children then
            return false, "Player has no children"
        end

        local child_names = {}
        for _, child in ipairs(children) do
            table.insert(child_names, child:get_entity_name())
        end
        return true, "Children: " .. table.concat(child_names, ", ")
    end,
})

minetest.register_chatcommand("lua_object_set_detach", {
    description = "Test the set_detach function",
    func = function(name)
        if param == "test" then
            param = ""
        end
        local player = minetest.get_player_by_name(name)
        if not player then
            return false, "Player not found"
        end

        player:set_detach()
        return true, "Player detached"
    end,
})

minetest.register_chatcommand("lua_object_set_properties", {
    description = "Test the set_properties function",
    params = "<properties>",
    func = function(name, param)
        if param == "test" then
            param = ""
        end
        local properties = minetest.parse_json(param)
        if not properties then
            return false, "Invalid properties format"
        end
        
        local player = minetest.get_player_by_name(name)
        if not player then
            return false, "Player not found"
        end

        player:set_properties(properties)
        return true, "Properties set"
    end,
})


minetest.register_chatcommand("lua_object_get_properties", {
    description = "Test the get_properties function",
    func = function(name)
        if param == "test" then
            param = ""
        end
        local player = minetest.get_player_by_name(name)
        if not player then
            return false, "Player not found"
        end

        local properties = player:get_properties()
        if not properties then
            return false, "Failed to get properties"
        end

        local properties_str = minetest.write_json(properties)
        return true, "Properties: " .. properties_str
    end,
})

-- Lua Testing for is_player
minetest.register_chatcommand("lua_object_is_player", {
    description = "Test the is_player function",
    func = function(name)
        if param == "test" then
            param = ""
        end
        local player = minetest.get_player_by_name(name)
        if not player then
            return false, "Player not found"
        end

        local is_player = player:is_player()
        return true, "Is player: " .. tostring(is_player)
    end,
})

-- Lua Testing for set_velocity
minetest.register_chatcommand("lua_object_set_velocity", {
    description = "Test the set_velocity function",
    params = "<velocity>",
    func = function(name, velocity)
        if velocity == "test" then
            velocity = "(0,-10,0)"
        end
        local vel = minetest.string_to_pos(velocity)
        if not vel then
            return false, "Invalid velocity format"
        end
        
        local player = minetest.get_player_by_name(name)
        if not player then
            return false, "Player not found"
        end

        player:set_velocity(vel)
        return true, "Velocity set to " .. minetest.pos_to_string(vel)
    end,
})

-- Lua Testing for add_velocity
minetest.register_chatcommand("lua_object_add_velocity", {
    description = "Test the add_velocity function",
    params = "<velocity>",
    func = function(name, velocity)
        if velocity == "test" then
            velocity = "(0,-10,0)"
        end
        local vel = minetest.string_to_pos(velocity)
        if not vel then
            return false, "Invalid velocity format"
        end
        
        local player = minetest.get_player_by_name(name)
        if not player then
            return false, "Player not found"
        end

        player:add_velocity(vel)
        return true, "Additional velocity applied: " .. minetest.pos_to_string(vel)
    end,
})

-- Lua Testing for get_velocity
minetest.register_chatcommand("lua_object_get_velocity", {
    description = "Test the get_velocity function",
    func = function(name)
        local player = minetest.get_player_by_name(name)
        if not player then
            return false, "Player not found"
        end

        local velocity = player:get_velocity()
        return true, "Current velocity: " .. minetest.pos_to_string(velocity)
    end,
})

-- Lua Testing for set_acceleration
minetest.register_chatcommand("lua_object_set_acceleration", {
    description = "Test the set_acceleration function",
    params = "<acceleration>",
    func = function(name, acceleration)
        if acceleration == "test" then
            acceleration = "(0,-10,0)"
        end
        local accel = minetest.string_to_pos(acceleration)
        if not accel then
            return false, "Invalid acceleration format"
        end
        
        local player = minetest.get_player_by_name(name)
        if not player then
            return false, "Player not found"
        end

        player:set_acceleration(accel)
        return true, "Acceleration set to " .. minetest.pos_to_string(accel)
    end,
})

-- Lua Testing for get_acceleration
minetest.register_chatcommand("lua_object_get_acceleration", {
    description = "Test the get_acceleration function",
    func = function(name)
        local player = minetest.get_player_by_name(name)
        if not player then
            return false, "Player not found"
        end

        local acceleration = player:get_acceleration()
        return true, "Current acceleration: " .. minetest.pos_to_string(acceleration)
    end,
})

-- Lua Testing for set_rotation
minetest.register_chatcommand("lua_object_set_rotation", {
    description = "Test the set_rotation function",
    params = "<rotation>",
    func = function(name, rotation)
        if rotation == "test" then
            rotation = "(0,-10,0)"
        end
        local rot = minetest.string_to_pos(rotation)
        if not rot then
            return false, "Invalid rotation format"
        end
        
        local player = minetest.get_player_by_name(name)
        if not player then
            return false, "Player not found"
        end

        player:set_rotation(rot)
        return true, "Rotation set to " .. minetest.pos_to_string(rot)
    end,
})

-- Lua Testing for get_rotation
minetest.register_chatcommand("lua_object_get_rotation", {
    description = "Test the get_rotation function",
    func = function(name)
        local player = minetest.get_player_by_name(name)
        if not player then
            return false, "Player not found"
        end

        local rotation = player:get_rotation()
        if not rotation then
            return false, "Unable to get rotation"
        end

        return true, "Current rotation: " .. minetest.pos_to_string(rotation)
    end,
})

-- /*======== NATIVE FUNCTIONS ========*/


-- n_remove
minetest.register_chatcommand("native_object_remove", {
    description = "Test Object Remove",
    func = function(name, param)
        if param == "test" then
            param = ""
        end

        minetest.log("native_object_remove is running!")
        local player = minetest.get_player_by_name(name)
        
        if not player then
            minetest.log("Player not found")
            return
        end

        local pos = player:get_pos()
        local saos = minetest.get_objects_inside_radius(pos, 8)
        
        -- Check if saos is empty
        if #saos == 0 then
            minetest.log("No Active Objects near Player")
            return
        end
        
        -- Output the size of saos to minetest.log
        minetest.log("Size of saos: " .. #saos)

        for i, object in ipairs(saos) do
            if not object:is_player() then
                minetest.log("Removed: "..object:get_entity_name())
                local objectRemove = object:native_remove()
            end
        end
    end,
})

-- n_get_pos
minetest.register_chatcommand("native_object_get_pos", {
    description = "Test Object Get Pos",
    func = function(name, param)
        if param == "test" then
            param = ""
        end
        minetest.log("native_object_get_pos is running!")
        local player = minetest.get_player_by_name(name)
        
        if not player then
            minetest.log("Player not found")
            return
        end

        local pos = player:get_pos()
        local saos = minetest.get_objects_inside_radius(pos, 1)
        
        -- Check if saos is empty
        if #saos == 0 then
            minetest.log("No Active Objects near Player")
            return
        end
        
        -- Output the size of saos to minetest.log
        minetest.log("Size of saos: " .. #saos)
        
        -- Get the position of the first object in saos
        local firstSaosPos = saos[1]:get_pos()
        minetest.log("Position of first Reference Object: " .. minetest.pos_to_string(firstSaosPos))
    end,
})

-- n_set_pos
minetest.register_chatcommand("native_object_set_pos", {
    description = "Test Object Set Pos - /native_object_set_pos (Z_Value)",
    func = function(name, param)
        if param == "test" then
            param = "33"
        end
        minetest.log("native_object_set_pos is running!")
        local player = minetest.get_player_by_name(name)
        
        if not player then
            minetest.log("Player not found")
            return
        end

        local pos = player:get_pos()
        local saos = minetest.get_objects_inside_radius(pos, 1)
        
        -- Check if saos is empty
        if #saos == 0 then
            minetest.log("No Active Objects near Player")
            return
        end
        
        -- Output the size of saos to minetest.log
        minetest.log("Size of Active Objects Array: " .. #saos)

        for i, object in ipairs(saos) do
            -- Check if the object is a player
            if object:is_player() then
                local v3f = {x = 100, y = 22, z = tonumber(param)}
                local player_pos = object:native_set_pos(v3f)
                minetest.log("Player " .. object:get_player_name() .. " is at position: " .. minetest.pos_to_string(v3f))
            end
        end
    end,
})  

-- l_move_to
minetest.register_chatcommand("native_object_move_to", {
    description = "Test Object Move To",
    func = function(name, param)
        if param == "test" then
            param = "15"
        end
        minetest.log("native_object_set_pos is running!")
        local player = minetest.get_player_by_name(name)
        
        if not player then
            minetest.log("Player not found")
            return
        end

        local pos = player:get_pos()
        local saos = minetest.get_objects_inside_radius(pos, 1)
        
        -- Check if saos is empty
        if #saos == 0 then
            minetest.log("No Active Objects near Player")
            return
        end
        
        -- Output the size of saos to minetest.log
        minetest.log("Size of Active Objects Array: " .. #saos)

        for i, object in ipairs(saos) do
            -- Check if the object is a player
            local v3f = {x = 100, y = 22, z = tonumber(param)}
            local player_pos = object:native_move_to(v3f, false)
            minetest.log(#saos .. " objects moved to position: " .. minetest.pos_to_string(v3f))
        end
    end,
})

-- l_punch
minetest.register_chatcommand("native'_object_punch", {
    description = "Test Object Move To",
    func = function(name, param)
        if param == "test" then
            param = ""
        end
        minetest.log("native'_object_set_pos is running!")
        local player = minetest.get_player_by_name(name)
        
        if not player then
            minetest.log("Player not found")
            return
        end

        local pos = player:get_pos()
        local saos = minetest.get_objects_inside_radius(pos, 2)
        
        -- Check if saos is empty
        if #saos == 0 then
            minetest.log("No Active Objects near Player")
            return
        end
        
        -- Output the size of saos to minetest.log
        minetest.log("Size of Active Objects Array: " .. #saos)

        for i, object in ipairs(saos) do
            -- Check if the object is a player
            if object:is_player() then
                for i, floorobj in ipairs(saos) do
                    if not floorobj:isplayer() then
                        -- Wear all objects on floor
                        -- punch(self, puncher, time_from_last_punch, tool_capabilities, dir)
                        -- object:punch(floorobj, 5, )
                    end
                end
            end
        end
    end,
})

-- l_right_click
-- right_click(self, clicker)
minetest.register_chatcommand("native_object_right_click", {
    description = "Test Object Right Click",
    func = function(name, param)
        if param == "test" then
            param = ""
        end
        minetest.log("native_object_right_click is running!")
        local player = minetest.get_player_by_name(name)
        
        if not player then
            minetest.log("Player not found")
            return
        end

        local pos = player:get_pos()
        local saos = minetest.get_objects_inside_radius(pos, 2)
        
        -- Check if saos is empty
        if #saos == 0 then
            minetest.log("No Active Objects near Player")
            return
        end
        
        -- Output the size of saos to minetest.log
        minetest.log("Size of Active Objects Array: " .. #saos)

        -- Insert native' code here that if saos == 2 then set plyr = saos[0] and rclk = saos[1]
        if #saos == 2 then
            local plyr = saos[1]
            local rclk = saos[2]
            plyr:native_right_click(rclk)
            minetest.log("Object: "..plyr:get_player_name().." right clicked on ".. rclk:get_entity_name())
        end
    end,
})

--set_hp
minetest.register_chatcommand("native_object_set_hp", {
    description = "Set the player's current HP - 0-20",
    func = function(name, param)
        if param == "test" then
            param = "12"
        end
        minetest.log("native_object_et_hp is running!")
        local player = minetest.get_player_by_name(name)
        
        if not player then
            minetest.log("Player not found")
            return
        end

        local pos = player:get_pos()
        local saos = minetest.get_objects_inside_radius(pos, 2)
        
        -- Check if saos is empty
        if #saos == 0 then
            minetest.log("No Active Objects near Player")
            return
        end
        
        -- Output the size of saos to minetest.log
        minetest.log("Size of Active Objects Array: " .. #saos)
        for i, object in ipairs(saos) do
            local a = object:native_set_hp(tonumber(param), "set_hp")
            minetest.log("The object's HP was set to " ..param)
            minetest.log("The object's HP is currently " ..dump(a))
        end
    end,
})

--get_hp
-- get_hp(self)
minetest.register_chatcommand("native_object_get_hp", {
    description = "Get the player's current HP",
    func = function(name, param)
        if param == "test" then
            param = ""
        end
        minetest.log("native_object_get_hp is running!")
        local player = minetest.get_player_by_name(name)
        
        if not player then
            minetest.log("Player not found")
            return
        end

        local pos = player:get_pos()
        local saos = minetest.get_objects_inside_radius(pos, 2)
        
        -- Check if saos is empty
        if #saos == 0 then
            minetest.log("No Active Objects near Player")
            return
        end
        
        -- Output the size of saos to minetest.log
        minetest.log("Size of Active Objects Array: " .. #saos)
        for i, object in ipairs(saos) do
            local a = object:native_get_hp()
            minetest.log("The object's HP is currently " ..dump(a))
        end
    end,
})

-- get_inventory(self)
minetest.register_chatcommand("native_object_get_inventory", {
    description = "Check player's inventory and returns inventory functions",
    func = function(name, param)
        if param == "test" then
            param = ""
        end
        minetest.log("native_object_get_inventory is running!")
        local player = minetest.get_player_by_name(name)
        
        if not player then
            minetest.log("Player not found")
            return
        end

        local pos = player:get_pos()
        local saos = minetest.get_objects_inside_radius(pos, 2)
        
        -- Check if saos is empty
        if #saos == 0 then
            minetest.log("No Active Objects near Player")
            return
        end
        
        -- Output the size of saos to minetest.log
        minetest.log("Size of Active Objects Array: " .. #saos)

        local plyr = saos[1]
        local a = plyr:native_get_inventory()
        minetest.log(dump(a:get_list("main")))
    end,
})

-- get_weild_list(self)
minetest.register_chatcommand("native_object_get_wield_list", {
    description = "Get the player's current wield list",
    func = function(name, param)
        if param == "test" then
            param = ""
        end
        minetest.log("native_object_get_weild_list is running!")
        local player = minetest.get_player_by_name(name)
        
        if not player then
            minetest.log("Player not found")
            return
        end

        local pos = player:get_pos()
        local saos = minetest.get_objects_inside_radius(pos, 2)
        
        -- Check if saos is empty
        if #saos == 0 then
            minetest.log("No Active Objects near Player")
            return
        end
        
        -- Output the size of saos to minetest.log
        minetest.log("Size of Active Objects Array: " .. #saos)

        local plyr = saos[1]
        local a = plyr:native_get_wield_list()
        minetest.log("The player's wield list is " ..dump(a))
    end,
})

-- get_weild_index(self)
minetest.register_chatcommand("native_object_get_wield_index", {
    description = "Get the player's current wield index",
    func = function(name, param)
        if param == "test" then
            param = ""
        end
        minetest.log("native_object_get_weild_index is running!")
        local player = minetest.get_player_by_name(name)
        
        if not player then
            minetest.log("Player not found")
            return
        end

        local pos = player:get_pos()
        local saos = minetest.get_objects_inside_radius(pos, 2)
        
        -- Check if saos is empty
        if #saos == 0 then
            minetest.log("No Active Objects near Player")
            return
        end
        
        -- Output the size of saos to minetest.log
        minetest.log("Size of Active Objects Array: " .. #saos)

        local plyr = saos[1]
        local a = plyr:native_get_wield_index()
        minetest.log("The player's wield list is " ..dump(a))
    end,
})


-- get_weilded_item(self)
minetest.register_chatcommand("native_object_get_wielded_item", {
    description = "Get the player's current wielded item",
    func = function(name, param)
        if param == "test" then
            param = ""
        end
        minetest.log("native_object_get_weilded_item is running!")
        local player = minetest.get_player_by_name(name)
        
        if not player then
            minetest.log("Player not found")
            return
        end

        local pos = player:get_pos()
        local saos = minetest.get_objects_inside_radius(pos, 2)
        
        -- Check if saos is empty
        if #saos == 0 then
            minetest.log("No Active Objects near Player")
            return
        end
        
        -- Output the size of saos to minetest.log
        minetest.log("Size of Active Objects Array: " .. #saos)

        local plyr = saos[1]
        local a = plyr:native_get_wielded_item()
        minetest.log("The player's wielded item is " ..dump(a))
        minetest.log("The player's wielded item is " ..dump(a:to_string()))
    end,
})


-- Look into
-- set_weilded_item(self)
minetest.register_chatcommand("native_object_set_wielded_item", {
    description = "Set the player's current wielded item",
    func = function(name, param)
        if param == "test" then
            param = "1"
        end
        minetest.log("native_object_set_weilded_item is running!")
        local player = minetest.get_player_by_name(name)
        
        if not player then
            minetest.log("Player not found")
            return
        end

        local pos = player:get_pos()
        local saos = minetest.get_objects_inside_radius(pos, 2)
        
        -- Check if saos is empty
        if #saos == 0 then
            minetest.log("No Active Objects near Player")
            return
        end
        
        -- Output the size of saos to minetest.log
        minetest.log("Size of Active Objects Array: " .. #saos)

        local plyr = saos[1]
        if tonumber(param) == 0 then
            local wieldeditem = nil
            local a = plyr:native_set_wielded_item(wieldeditem)
            minetest.log("The player's wielded item is " ..dump(a))
        elseif tonumber(param) == 1 then
            local wieldeditem = "basetools:sword_stone"
            local a = plyr:native_set_wielded_item(wieldeditem)
            minetest.log("The player's wielded item is " ..dump(a))
        else
            minetest.log("input a param: \n 0 - null \n 1 - stone sword")
        end
    end,
})


--Skip set armor (fleshy, crumbly, cracky)

-- get_armor_groups(self)
minetest.register_chatcommand("native_object_get_armor_groups", {
    description = "Get the player's current armor groups",
    func = function(name, param)
        if param == "test" then
            param = ""
        end
        minetest.log("native_object_get_weilded_item is running!")
        local player = minetest.get_player_by_name(name)
        
        if not player then
            minetest.log("Player not found")
            return
        end

        local pos = player:get_pos()
        local saos = minetest.get_objects_inside_radius(pos, 2)
        
        -- Check if saos is empty
        if #saos == 0 then
            minetest.log("No Active Objects near Player")
            return
        end
        
        -- Output the size of saos to minetest.log
        minetest.log("Size of Active Objects Array: " .. #saos)

        local plyr = saos[1]
        local a = plyr:native_get_armor_groups()
        local b = player:native_get_armor_groups()
        -- minetest.log("The player's armor group information is " ..dump(a:to_string()))
        minetest.log("The player's armor group information is " ..dump(a))
        minetest.log("The player's armor group information is " ..dump(b))
    end,
})


-- set_animation(self, frame_range, frame_speed, frame_blend, frame_loop)
-- get_animation(self)
minetest.register_chatcommand("native_object_get_animation", {
    description = "Get the object's animation",
    func = function(name, param)
        if param == "test" then
            param = ""
        end
        minetest.log("native_object_get_animation is running!")
        local player = minetest.get_player_by_name(name)
        
        if not player then
            minetest.log("Player not found")
            return
        end

        local pos = player:get_pos()
        local saos = minetest.get_objects_inside_radius(pos, 2)
        
        -- Check if saos is empty
        if #saos == 0 then
            minetest.log("No Active Objects near Player")
            return
        end
        
        -- Output the size of saos to minetest.log
        minetest.log("Size of Active Objects Array: " .. #saos)

        if #saos == 2 then
            -- local plyr = saos[1]
            local rclk = saos[2]
            local a = rclk:native_get_animation()
            minetest.log("The Current animation information for ".. rclk:get_entity_name().." is "..dump(a))
        else
            local plyr = saos[1]
            local a = plyr:native_get_animation()
            minetest.log("The Current animation information for ".. plyr:get_player_name() .." is "..dump(a))
        end
    end,
})
-- set_local_animation(self, idle, walk, dig, walk_while_dog, frame_speed)
-- get_local_animation(self)
minetest.register_chatcommand("native_object_get_local_animation", {
    description = "Get the player's animation",
    func = function(name, param)
        if param == "test" then
            param = ""
        end
        minetest.log("native_object_get_local_animation_item is running!")
        local player = minetest.get_player_by_name(name)
        
        if not player then
            minetest.log("Player not found")
            return
        end

        local pos = player:get_pos()
        local saos = minetest.get_objects_inside_radius(pos, 2)
        
        -- Check if saos is empty
        if #saos == 0 then
            minetest.log("No Active Objects near Player")
            return
        end
        
        -- Output the size of saos to minetest.log
        minetest.log("Size of Active Objects Array: " .. #saos)


        local plyr = saos[1]
        local a = plyr:native_get_local_animation()
        minetest.log("The Current animation information for ".. plyr:get_player_name() .." is "..dump(a))
    end,
})

-- get_eye_offset(self)
minetest.register_chatcommand("native_object_get_eye_offset", {
    description = "Get the player's current eye offset",
    func = function(name, param)
        if param == "test" then
            param = ""
        end
        minetest.log("native_object_get_eye_offset is running!")
        local player = minetest.get_player_by_name(name)
        
        if not player then
            minetest.log("Player not found")
            return
        end

        local pos = player:get_pos()
        local saos = minetest.get_objects_inside_radius(pos, 2)
        
        -- Check if saos is empty
        if #saos == 0 then
            minetest.log("No Active Objects near Player")
            return
        end
        
        -- Output the size of saos to minetest.log
        minetest.log("Size of Active Objects Array: " .. #saos)

        local plyr = saos[1]
        local a = plyr:native_get_eye_offset()
        --local b = player:get_armor_groups()
        -- minetest.log("The player's armor group information is " ..dump(a:to_string()))
        minetest.log("The player's eye offset is " ..dump(a))

    end,
})


-- set_eye_offset(self)
minetest.register_chatcommand("native_object_set_eye_offset", {
    description = "Set the player's current eye offset",
    func = function(name, param)
        if param == "test" then
            param = "14"
        end
        minetest.log("native_object_get_eye_offset is running!")
        local player = minetest.get_player_by_name(name)
        
        if not player then
            minetest.log("Player not found")
            return
        end

        local pos = player:get_pos()
        local saos = minetest.get_objects_inside_radius(pos, 2)
        
        -- Check if saos is empty
        if #saos == 0 then
            minetest.log("No Active Objects near Player")
            return
        end
        
        -- Output the size of saos to minetest.log
        minetest.log("Size of Active Objects Array: " .. #saos)

        local plyr = saos[1]
        if param ~= "" then
            local v3f = {x = 0, y = tonumber(param), z = 0}
            local a = plyr:native_set_eye_offset(v3f)
            minetest.log("The player's eye offset is now" ..dump(v3f))
        else
            local v3f = {x = 0, y = 0, z = 0}
            local a = plyr:native_set_eye_offset(v3f)
            minetest.log("native_object_set_eye_offset # (0 is default)")
        end
    end,
})


-- send_mapblock(self, pos)
-- Figure out how to trigger it
minetest.register_chatcommand("native_object_send_mapblock", {
    description = "Sends an already loaded mapblock to the player.\nReturns false if nothing was sent (note that this can also mean that the client already has the block)\nResource intensive - use sparsely",
    func = function(name, param)
        if param == "test" then
            param = ""
        end
        minetest.log("Sends an already loaded mapblock to the player.\nReturns false if nothing was sent (note that this can also mean that the client already has the block)\nResource intensive - use sparsely")
        local player = minetest.get_player_by_name(name)
        
        if not player then
            minetest.log("Player not found")
            return
        end

        local pos = player:get_pos()
        local saos = minetest.get_objects_inside_radius(pos, 2)
        
        -- Check if saos is empty
        if #saos == 0 then
            minetest.log("No Active Objects near Player")
            return
        end
        
        -- Output the size of saos to minetest.log
        minetest.log("Size of Active Objects Array: " .. #saos)

        local plyr = saos[1]
        local a = plyr:native_send_mapblock(pos)
        --local b = player:get_armor_groups()
        -- minetest.log("The player's armor group information is " ..dump(a:to_string()))
        if a then
            minetest.log("Mapblock was sent to player. Responce:  " ..dump(a))
        else 
            minetest.log("Mapblock was NOT sent to player. Responce:  " ..dump(a))
        end
    end,
})


--set_animation_frame_speed(self, frame_speed)

--set_bone_position(self, bone, position, rotation)

--get_bone_position(self, bone)

--set_attach(self, parent, bone, position, rotation, force_visable)

--get_attach(self)

--get_children(self)

--set_detach(self)

--set_properties(self, properties)

--get_properties(self)

--is_player(self) Used in most functions

--set_nametag_attributes

-- Chris Functions
-- l_set_breath
minetest.register_chatcommand("native_object_set_breath", {
    description = "Test Set Breath - /native_object_set_breath (breath_value)",
    func = function(name, param)
        if param == "test" then
            param = "1"
        end
        minetest.log("native_object_set_breath is running!")
        local player = minetest.get_player_by_name(name)

        if not player then
            minetest.log("Player not found")
            return
        end

        local breath_value = tonumber(param)
        if not breath_value then
            minetest.log("Invalid breath value")
            return
        end

        player:native_set_breath(breath_value)
        minetest.log("Player breath set to: " .. breath_value)
    end,
})

-- l_get_breath
minetest.register_chatcommand("native_object_get_breath", {
    description = "Test Get Breath",
    func = function(name, param)
        if param == "test" then
            param = ""
        end
        minetest.log("native_object_get_breath is running!")
        local player = minetest.get_player_by_name(name)

        if not player then
            minetest.log("Player not found")
            return
        end

        local breath = player:native_get_breath()
        minetest.log("Player's current breath: " .. breath)
    end,
})

-- l_set_fov
minetest.register_chatcommand("native_object_set_fov", {
    description = "Test Set FOV - /native_object_set_fov (degrees) (is_multiplier) (transition_time)",
    func = function(name, param)
        if param == "test" then
            param = "90 false 1"
        end
        minetest.log("native_object_set_fov is running!")
        local player = minetest.get_player_by_name(name)

        if not player then
            minetest.log("Player not found")
            return
        end
        
        local degrees, is_multiplier, transition_time = string.match(param, "^(%-?%d+%.?%d*) (%a+) (%d+%.?%d*)$")
        degrees = tonumber(degrees)
        transition_time = tonumber(transition_time)
        is_multiplier = is_multiplier == "true"
        
        if not degrees or is_multiplier == nil or not transition_time then
            minetest.log("Invalid FOV values")
            return
        end
        
        player:native_set_fov(degrees, is_multiplier, transition_time)
        minetest.log("Player FOV set to: degrees: " .. degrees .. " is_multiplier: " .. tostring(is_multiplier) .. " transition_time: " .. transition_time)
    end,
})

-- l_get_fov
minetest.register_chatcommand("native_object_get_fov", {
    description = "Test Get FOV",
    func = function(name, param)
        if param == "test" then
            param = ""
        end
        minetest.log("native_object_get_fov is running!")
        local player = minetest.get_player_by_name(name)
        
        if not player then
            minetest.log("Player not found")
            return
        end
        
        local degrees, is_multiplier, transition_time = player:native_get_fov()
        minetest.log("Player's current FOV: degrees: " .. degrees .. " is_multiplier: " .. tostring(is_multiplier) .. " transition_time: " .. transition_time)
    end,
})

-- l_set_attribute
minetest.register_chatcommand("native_object_set_attribute", {
    description = "Test Set Attribute - /native_object_set_attribute (attribute) (value)",
    func = function(name, param)
        if param == "test" then
            param = "breath 10"
        end
        minetest.log("native_object_set_attribute is running!")
        local player = minetest.get_player_by_name(name)
        
        if not player then
            minetest.log("Player not found")
            return
        end
        
        local attribute, value = string.match(param, "^([^ ]+) (.+)$")
        
        if not attribute or not value then
            minetest.log("Invalid attribute or value")
            return
        end
        
        player:native_set_attribute(attribute, value)
        minetest.log("Player " .. attribute .. " set to: " .. value)
    end,
})

-- l_get_attribute
minetest.register_chatcommand("native_object_get_attribute", {
    description = "Test Get Attribute - /native_object_get_attribute (attribute)",
    func = function(name, param)
        if param == "test" then
            param = "breath"
        end
        minetest.log("native_object_get_attribute is running!")
        local player = minetest.get_player_by_name(name)
        
        if not player then
            minetest.log("Player not found")
            return
        end
        
        local attribute = param
        
        if not attribute then
            minetest.log("Invalid attribute")
            return
        end
        
        local value = player:native_get_attribute(attribute)
        minetest.log("Player's " .. attribute .. ": " .. (value or "nil"))
    end,
})

-- l_get_meta
minetest.register_chatcommand("native_object_get_meta", {
    description = "Test Get Meta",
    func = function(name, param)
        if param == "test" then
            param = ""
        end
        minetest.log("native_object_get_meta is running!")
        local player = minetest.get_player_by_name(name)
        
        if not player then
            minetest.log("Player not found")
            return
        end
        
        local meta = player:native_get_meta()
        
        if meta then
            minetest.log("Player Meta Retrieved")
        else
            minetest.log("Failed to Retrieve Player Meta")
        end
    end,
})


-- l_get_look_dir
minetest.register_chatcommand("native_object_get_look_dir", {
    description = "Test Look Direction",
    func = function(name, param)
        if param == "test" then
            param = ""
        end
        minetest.log("native_object_get_look_dir is running!")
        local player = minetest.get_player_by_name(name)

        if not player then
            minetest.log("Player not found")
            return
        end

        local look_dir = player:native_get_look_dir()
        minetest.log("Player's look direction (native): " .. minetest.pos_to_string(look_dir))
    end,
})



-- DEPRECATED: l_get_look_pitch
minetest.register_chatcommand("native_object_get_look_pitch", {
    description = "Test Deprecated Get Look Pitch",
    func = function(name, param)
        if param == "test" then
            param = ""
        end
        minetest.log("native_object_get_look_pitch is running!")
        local player = minetest.get_player_by_name(name)
        if not player then
            minetest.log("Player not found")
            return
        end

        local look_pitch = player:native_get_look_pitch()
        minetest.log("Deprecated Look Pitch: " .. look_pitch)
    end,
})

-- DEPRECATED: l_get_look_yaw
minetest.register_chatcommand("native_object_get_look_yaw", {
    description = "Test Deprecated Get Look Yaw",
    func = function(name, param)
        if param == "test" then
            param = ""
        end
        minetest.log("native_object_get_look_yaw is running!")
        local player = minetest.get_player_by_name(name)
        if not player then
            minetest.log("Player not found")
            return
        end

        local look_yaw = player:native_get_look_yaw()
        minetest.log("Deprecated Look Yaw: " .. look_yaw)
    end,
})

-- l_get_look_vertical
minetest.register_chatcommand("native_object_get_look_vertical", {
    description = "Test Get Look Vertical",
    func = function(name, param)
        if param == "test" then
            param = ""
        end
        minetest.log("native_object_get_look_vertical is running!")
        local player = minetest.get_player_by_name(name)
        if not player then
            minetest.log("Player not found")
            return
        end

        local look_vertical = player:native_get_look_vertical()
        minetest.log("Look Vertical: " .. look_vertical)
    end,
})

-- l_get_look_horizontal
minetest.register_chatcommand("native_object_get_look_horizontal", {
    description = "Test Get Look Horizontal",
    func = function(name, param)
        if param == "test" then
            param = ""
        end
        minetest.log("native_object_get_look_horizontal is running!")
        local player = minetest.get_player_by_name(name)
        if not player then
            minetest.log("Player not found")
            return
        end

        local look_horizontal = player:native_get_look_horizontal()
        minetest.log("Look Horizontal: " .. look_horizontal)
    end,
})



-- native l_set_look_vertical
minetest.register_chatcommand("native_object_set_look_vertical", {
    description = "Test native Set Look Vertical - /native_object_set_look_vertical (radians)",
    func = function(name, param)
        if param == "test" then
            param = "20"
        end
        local player = minetest.get_player_by_name(name)
        if not player then
            minetest.log("Player not found")
            return
        end

        local radians = tonumber(param)
        if not radians then
            minetest.log("Invalid radian value")
            return
        end

        player:native_set_look_vertical(radians)
    end,
})

-- native l_set_look_horizontal
minetest.register_chatcommand("native_object_set_look_horizontal", {
    description = "Test native Set Look Horizontal - /native_object_set_look_horizontal (radians)",
    func = function(name, param)
        if param == "test" then
            param = "20"
        end
        local player = minetest.get_player_by_name(name)
        if not player then
            minetest.log("Player not found")
            return
        end

        local radians = tonumber(param)
        if not radians then
            minetest.log("Invalid radian value")
            return
        end

        player:native_set_look_horizontal(radians)
    end,
})

-- DEPRECATED: native l_set_look_pitch
minetest.register_chatcommand("native_object_set_look_pitch", {
    description = "Test (Deprecated) native Set Look Pitch - /native_object_set_look_pitch (radians)",
    func = function(name, param)
        if param == "test" then
            param = "20"
        end
        local player = minetest.get_player_by_name(name)
        if not player then
            minetest.log("Player not found")
            return
        end

        local radians = tonumber(param)
        if not radians then
            minetest.log("Invalid radian value")
            return
        end

        player:set_look_pitch(radians)
    end,
})

-- DEPRECATED: native l_set_look_yaw
minetest.register_chatcommand("native_object_set_look_yaw", {
    description = "Test (Deprecated) native Set Look Yaw - /native_object_set_look_yaw (radians)",
    func = function(name, param)
        if param == "test" then
            param = "20"
        end
        local player = minetest.get_player_by_name(name)
        if not player then
            minetest.log("Player not found")
            return
        end

        local radians = tonumber(param)
        if not radians then
            minetest.log("Invalid radian value")
            return
        end

        player:native_set_look_yaw(radians)
    end,
})



-- native Testing for set_sky
minetest.register_chatcommand("native_object_set_sky", {
    description = "Set Sky Parameters",
    func = function(name, param)
        if param == "test" then
            param = ""
        end
        local player = minetest.get_player_by_name(name)
        if not player then
            minetest.log("Player not found!")
            return
        end
        -- Example sky parameters, you can modify as needed
        local sky_parameters = {
            base_color = "#ABCDEF",
            type = "regular",
            textures = {"sky_texture_1.png", "sky_texture_2.png", },
            clouds = true,
            sky_color = {
                day_sky = "#ABCDEF",
                day_horizon = "#ABCDEF",
                dawn_sky = "#ABCDEF",
                dawn_horizon = "#ABCDEF",
                night_sky = "#ABCDEF",
                night_horizon = "#ABCDEF",
                indoors = "#ABCDEF"
            }
        }
        player:native_set_sky(sky_parameters)
        minetest.log("Sky parameters set for player: " .. name)
    end
})

-- native Testing for get_sky
minetest.register_chatcommand("native_object_get_sky", {
    description = "Retrieve Sky Parameters",
    func = function(name, param)
        if param == "test" then
            param = ""
        end
        local player = minetest.get_player_by_name(name)
        if not player then
            minetest.log("Player not found!")
            return
        end
        local sky = player:native_get_sky()
        -- Here you can process and display the 'sky' data as needed
        minetest.log(dump(sky))
    end
})


-- native Testing for get_sky_color
minetest.register_chatcommand("native_object_get_sky_color", {
    description = "Retrieve Sky Colors",
    func = function(name, param)
        if param == "test" then
            param = ""
        end
        local player = minetest.get_player_by_name(name)
        if not player then
            minetest.log("Player not found!")
            return
        end
        local sky_color = player:native_get_sky_color()
        -- Here you can process and display the 'sky_color' data as needed
        minetest.log(dump(sky_color))
    end
})

-- native Testing for set_sun
minetest.register_chatcommand("native_object_set_sun", {
    description = "Test set_sun - /native_object_set_sun",
    func = function(name, param)
        if param == "test" then
            param = ""
        end
        local player = minetest.get_player_by_name(name)
        if not player then
            return false, "Player not found"
        end

        local sun_params = {
            visible = true,
            texture = "some_texture.png",
            tonemap = "some_tonemap.png",
            sunrise = "some_sunrise.png",
            sunrise_visible = true,
            scale = 1.0
        }
        player:native_set_sun(sun_params)
        return true, "Sun parameters set using native_object_set_sun"
    end,
})

-- native Testing for get_sun
minetest.register_chatcommand("native_object_get_sun", {
    description = "Test get_sun - /native_object_get_sun",
    func = function(name, _)
        local player = minetest.get_player_by_name(name)
        if not player then
            return false, "Player not found"
        end

        local sun_params = player:native_get_sun()
        -- Here, you can either print the parameters or use them further
        return true, "Got sun parameters using native_object_get_sun"
    end,
})

-- native Testing for set_moon
minetest.register_chatcommand("native_object_set_moon", {
    description = "Test set_moon - /native_object_set_moon",
    func = function(name, param)
        if param == "test" then
            param = ""
        end
        local player = minetest.get_player_by_name(name)
        if not player then
            return false, "Player not found"
        end

        local moon_params = {
            visible = true,
            texture = "some_moon_texture.png",
            tonemap = "some_moon_tonemap.png",
            scale = 1.0
        }
        player:native_set_moon(moon_params)
        return true, "Moon parameters set using native_object_set_moon"
    end,
})

-- native Testing for get_moon
minetest.register_chatcommand("native_object_get_moon", {
    description = "Test get_moon - /native_object_get_moon",
    func = function(name, _)
        local player = minetest.get_player_by_name(name)
        if not player then
            return false, "Player not found"
        end

        local moon_params = player:native_get_moon()
        -- Here, you can either print the parameters or use them further
        return true, "Got moon parameters using native_object_get_moon"
    end,
})


-- native Testing for set_stars
minetest.register_chatcommand("native_object_set_stars", {
    description = "Test Set Stars",
    func = function(name, param)
        if param == "test" then
            param = "1 {visible=true, count=1000, star_color={a=255, r=255, g=255, b=255}, scale=1.0}"
        end
        local player = minetest.get_player_by_name(name)
        if not player then
            minetest.log("Player not found")
            return
        end
        player:native_set_stars({
            visible = true,
            count = 500,
            star_color = {a=255, r=255, g=255, b=255},
            scale = 1.0
        })
        minetest.log("Stars set for player: " .. name)
    end,
})

-- native Testing for get_stars
minetest.register_chatcommand("native_object_get_stars", {
    description = "Test Get Stars",
    func = function(name, param)
        if param == "test" then
            param = ""
        end
        local player = minetest.get_player_by_name(name)
        if not player then
            minetest.log("Player not found")
            return
        end
        local stars = player:native_get_stars()
        minetest.log(dump(stars))
    end,
})

-- native Testing for set_clouds
minetest.register_chatcommand("native_object_set_clouds", {
    description = "Test Set Clouds",
    func = function(name, param)
        if param == "test" then
            param = "1 {density=0.5, color={a=255, r=255, g=255, b=255}, ambient={a=255, r=255, g=255, b=255}, height=120, thickness=16, speed={x=0, y=0}}"
        end
        local player = minetest.get_player_by_name(name)
        if not player then
            minetest.log("Player not found")
            return
        end
        player:native_set_clouds({
            density = 0.6,
            color = {a=255, r=255, g=255, b=255},
            ambient = {a=255, r=128, g=128, b=128},
            height = 120,
            thickness = 16,
            speed = {x=0, y=2}
        })
        minetest.log("Clouds set for player: " .. name)
    end,
})

-- native Testing for get_clouds
minetest.register_chatcommand("native_object_get_clouds", {
    description = "Test Get Clouds",
    func = function(name, param)
        if param == "test" then
            param = ""
        end
        local player = minetest.get_player_by_name(name)
        if not player then
            minetest.log("Player not found")
            return
        end
        local clouds = player:native_get_clouds()
        minetest.log(dump(clouds))
    end,
})

-- Test l_get_entity_name Function
minetest.register_chatcommand("native_object_get_entity_name", {
    description = "Test Get Entity Name",
    func = function(name, param)
        if param == "test" then
            param = ""
        end
        minetest.log("Testing l_get_entity_name...")
        local player = minetest.get_player_by_name(name)
        
        if not player then
            minetest.log("Player not found")
            return
        end

        local saos = minetest.get_objects_inside_radius(player:get_pos(), 8)
        
        for i, object in ipairs(saos) do
            if not object:is_player() then
                local entityName = object:native_get_entity_name()
                minetest.log("Entity Name: " .. entityName)
            end
        end
    end,
})

-- Test l_get_player_name Function
minetest.register_chatcommand("native_object_get_player_name", {
    description = "Test Get Player Name",
    func = function(name, param)
        if param == "test" then
            param = ""
        end
        local player = minetest.get_player_by_name(name)
        if player then
            minetest.log("Player Name: " .. player:native_get_player_name())
        else
            minetest.log("Player not found")
        end
    end,
})

-- Test l_get_luaentity Function
minetest.register_chatcommand("native_object_get_luaentity", {
    description = "Test LuaEntity",
    func = function(name, param)
        if param == "test" then
            param = ""
        end
        minetest.log("Testing l_get_luaentity...")
        local player = minetest.get_player_by_name(name)
        
        if not player then
            minetest.log("Player not found")
            return
        end

        local saos = minetest.get_objects_inside_radius(player:get_pos(), 8)
        
        for i, object in ipairs(saos) do
            if not object:is_player() then
                local luaEntity = object:native_get_luaentity()
                minetest.log("LuaEntity ID: " .. (luaEntity and luaEntity:get_id() or "nil"))
            end
        end
    end,
})


-- native Testing for override_day_night_ratio
minetest.register_chatcommand("native_object_override_day_night_ratio", {
    description = "native Test Override Day Night Ratio",
    func = function(name, param)
        if param == "test" then
            param = "0.5"
        end
        local player = minetest.get_player_by_name(name)
        if not player then
            minetest.log("Player not found")
            return
        end
        local ratio = tonumber(param) or 0.5
        player:native_override_day_night_ratio(ratio)
        minetest.log("Day Night Ratio (native) set to: " .. ratio .. " for player: " .. name)
    end,
})

-- native Testing for get_day_night_ratio
minetest.register_chatcommand("native_object_get_day_night_ratio", {
    description = "native Test Get Day Night Ratio",
    func = function(name, param)
        if param == "test" then
            param = ""
        end
        local player = minetest.get_player_by_name(name)
        if not player then
            minetest.log("Player not found")
            return
        end
        local ratio = player:native_get_day_night_ratio()
        minetest.log("Day Night Ratio (native) for player " .. name .. " is: " .. (ratio or "Not set"))
    end,
})

-- native Testing for hud_set_hotbar_itemcount
minetest.register_chatcommand("native_object_hud_set_hotbar_itemcount", {
    description = "native Test Set Hotbar Item Count",
    func = function(name, param)
        if param == "test" then
            param = "65"
        end
        local player = minetest.get_player_by_name(name)
        if not player then
            minetest.log("Player not found")
            return
        end

        player:native_hud_set_hotbar_itemcount(tonumber(param) or 8) -- default to 8 if no input
    end,
})

-- native Testing for hud_get_hotbar_itemcount
minetest.register_chatcommand("native_object_hud_get_hotbar_itemcount", {
    description = "native Test Get Hotbar Item Count",
    func = function(name, param)
        if param == "test" then
            param = ""
        end
        local player = minetest.get_player_by_name(name)
        if not player then
            return "Player not found"
        end

        local count = player:native_hud_get_hotbar_itemcount()
        return true, "Hotbar Item Count: " .. count
    end,
})

-- native Testing for hud_set_hotbar_image
minetest.register_chatcommand("native_object_hud_set_hotbar_image", {
    description = "native Test Set Hotbar Image",
    func = function(name, param)
        if param == "test" then
            param = ""
        end
        local player = minetest.get_player_by_name(name)
        if not player then
            minetest.log("Player not found")
            return
        end

        player:native_hud_set_hotbar_image(param) -- set to the provided image name
    end,
})

-- native Testing for hud_get_hotbar_image
minetest.register_chatcommand("native_object_hud_get_hotbar_image", {
    description = "native Test Get Hotbar Image",
    func = function(name, param)
        if param == "test" then
            param = ""
        end
        local player = minetest.get_player_by_name(name)
        if not player then
            return "Player not found"
        end

        local image = player:native_hud_get_hotbar_image()
        return true, "Hotbar Image: " .. image
    end,
})

-- native Testing for hud_add
minetest.register_chatcommand("native_object_hud_add", {
    description = "Test the hud_add function",
    func = function(name)
        if param == "test" then
            param = ""
        end
        local player = minetest.get_player_by_name(name)
        if not player then
            return false, "Player not found"
        end
        
        local hud_def = {
            hud_elem_type = "image",
            position = {x = 0.5, y = 0.5},
            offset = {x = 0, y = 0},
            text = "default_wood.png",
            scale = {x = 2, y = 2},
            alignment = {x = 0, y = 0},
        }
        local id = player:native_hud_add(hud_def)
        
        if id then
            minetest.chat_send_player(name, "HUD element added with ID: " .. id)
            return true
        else
            return false, "Failed to add HUD element"
        end
    end,
})


-- native Testing for hud_remove
minetest.register_chatcommand("native_object_hud_remove", {
    description = "Test the hud_remove function",
    func = function(name, param)
        if param == "test" then
            param = ""
        end
        local player = minetest.get_player_by_name(name)
        if not player then
            return false, "Player not found"
        end

        local id = tonumber(param)
        if not id then
            return false, "Invalid HUD ID"
        end
        
        local success = player:native_hud_remove(id)
        return success, success and "HUD element removed." or "Failed to remove HUD element."
    end,
})


-- native Testing for hud_change
minetest.register_chatcommand("native_object_hud_change", {
    description = "Test the hud_change function",
    func = function(name, param)
        if param == "test" then
            param = ""
        end
        local player = minetest.get_player_by_name(name)
        if not player then
            return false, "Player not found"
        end

        local id, stat, data = parse_hud_change_parameters(param)
        if not id then
            return false, "Invalid parameters"
        end
        
        player:native_hud_change(id, stat, data)
        return true, "HUD element changed."
    end,
})


-- native Testing for hud_change
minetest.register_chatcommand("native_object_hud_change", {
    description = "Test the hud_change function",
    func = function(name, param)
        if param == "test" then
            param = ""
        end
        local player = minetest.get_player_by_name(name)
        if not player then
            return false, "Player not found"
        end

        local id, stat, data = parse_hud_change_parameters(param)
        if not id then
            return false, "Invalid parameters"
        end
        
        player:native_hud_change(id, stat, data)
        return true, "HUD element changed."
    end,
})



-- native Testing for hud_set_flags
minetest.register_chatcommand("native_object_hud_set_flags", {
    description = "Test the hud_set_flags function",
    func = function(name)
        if param == "test" then
            param = ""
        end
        local player = minetest.get_player_by_name(name)
        if not player then
            return false, "Player not found"
        end
        
        local flags = {
            hotbar = false,
            healthbar = false,
            crosshair = true,
            wielditem = true,
            breathbar = false,
            minimap = true,
            minimap_radar = true,
        }
        
        local success = player:native_hud_set_flags(flags)
        return success, success and "HUD flags set." or "Failed to set HUD flags."
    end,
})



-- native Testing for hud_get_flags
minetest.register_chatcommand("native_object_hud_get_flags", {
    description = "Test the hud_get_flags function",
    func = function(name)
        if param == "test" then
            param = ""
        end
        local player = minetest.get_player_by_name(name)
        if not player then
            return false, "Player not found"
        end
        
        local flags = player:native_hud_get_flags()
        if flags then
            -- serialize or use the flags for assertion
            return true, minetest.serialize(flags)
        else
            return false, "Failed to get HUD flags."
        end
    end,
})


-- native Testing for hud_set_hotbar_selected_image
minetest.register_chatcommand("native_object_set_hotbar_selected_image", {
    description = "Test the hud_set_hotbar_selected_image function",
    func = function(name, param)
        if param == "test" then
            param = ""
        end
        local player = minetest.get_player_by_name(name)
        if not player then
            return false, "Player not found"
        end

        if param and param ~= "" then
            player:native_hud_set_hotbar_selected_image(param)
            return true, "Hotbar selected image set to " .. param
        else
            return false, "Invalid image name"
        end
    end,
})


-- native Testing for hud_get_hotbar_selected_image
minetest.register_chatcommand("native_object_get_hotbar_selected_image", {
    description = "Test the hud_get_hotbar_selected_image function",
    func = function(name)
        if param == "test" then
            param = ""
        end
        local player = minetest.get_player_by_name(name)
        if not player then
            return false, "Player not found"
        end

        local image_name = player:native_hud_get_hotbar_selected_image()
        if image_name then
            return true, "Hotbar selected image is: " .. image_name
        else
            return false, "Failed to get hotbar selected image"
        end
    end,
})


-- native Testing for set_yaw
minetest.register_chatcommand("native_object_set_yaw", {
    description = "Test the set_yaw function",
    params = "<yaw>",
    func = function(name, param)
        if param == "test" then
            param = "20"
        end
        local player = minetest.get_player_by_name(name)
        if not player then
            return false, "Player not found"
        end

        local yaw = tonumber(param)
        if not yaw then
            return false, "Invalid yaw value"
        end
        
        player:native_set_yaw(yaw)
        return true, "Yaw set to " .. yaw
    end,
})


-- native Testing for get_yaw
minetest.register_chatcommand("native_object_get_yaw", {
    description = "Test the get_yaw function",
    func = function(name)
        if param == "test" then
            param = ""
        end
        local player = minetest.get_player_by_name(name)
        if not player then
            return false, "Player not found"
        end

        local yaw = player:native_get_yaw()
        return true, "Current yaw: " .. yaw
    end,
})


-- native Testing for set_texture_mod
minetest.register_chatcommand("native_object_set_texture_mod", {
    description = "Test the set_texture_mod function",
    params = "<mod>",
    func = function(name, param)
        if param == "test" then
            param = ""
        end
        local player = minetest.get_player_by_name(name)
        if not player then
            return false, "Player not found"
        end

        player:native_set_texture_mod(param)
        return true, "Texture mod set to " .. param
    end,
})


-- native Testing for get_texture_mod
minetest.register_chatcommand("native_object_get_texture_mod", {
    description = "Test the get_texture_mod function",
    func = function(name)
        local player = minetest.get_player_by_name(name)
        if not player then
            return false, "Player not found"
        end

        local mod = player:native_get_texture_mod()
        return true, "Current texture mod: " .. mod
    end,
})

-- native Testing for set_sprite
minetest.register_chatcommand("native_object_set_sprite", {
    description = "Test the set_sprite function",
    params = "<start_frame> <num_frames> <framelength> <select_x_by_camera>",
    func = function(name, param)
        if param == "test" then
            param = ""
        end
        local start_frame, num_frames, framelength, select_x_by_camera =
            param:match("^(%d+)%s+(%d+)%s+(%f+)%s+(%a+)$")

        if not (start_frame and num_frames and framelength and select_x_by_camera) then
            return false, "Invalid parameters. Provide start_frame, num_frames, framelength, select_x_by_camera."
        end

        start_frame = tonumber(start_frame)
        num_frames = tonumber(num_frames)
        framelength = tonumber(framelength)
        select_x_by_camera = select_x_by_camera == "true"

        local player = minetest.get_player_by_name(name)
        if not player then
            return false, "Player not found"
        end

        -- Assuming set_sprite function exists and works as follows:
        player:native_set_sprite({x=start_frame, y=0}, num_frames, framelength, select_x_by_camera)
        return true, "Sprite set successfully"
    end,
})

-- /*======== TEST FUNCTIONS ========*/

-- /*======== AUTOMATED TESTING ========*/

-- Function to run all lua_object commands and log the results
-- Automated Testing
local function run_lua_object_commands_and_log()
    local log_file = io.open(minetest.get_worldpath() .. "/lua_object_results.txt", "w")  -- Open a text file for writing

    if not log_file then
        minetest.log("Failed to open log file for writing.")
        return
    end

    local total_commands = 0  
    local passed_commands = 0 

    for command, command_info in pairs(minetest.registered_chatcommands) do
        if string.match(command, "^lua_object_") then
            minetest.log("Running lua_object command: " .. command)

            local start_time = os.clock()  -- Record the start time
            local success, result = pcall(command_info.func, "singleplayer", "test")
            local end_time = os.clock()  -- Record the end time

            local execution_time = end_time - start_time  -- Calculate the execution time

            log_file:write("Command: " .. command .. "\n")
            log_file:write("Result: " .. (success and "Success" or "Error") .. "\n")
            log_file:write("Execution Time: " .. execution_time .. " seconds\n")

            if success then
                log_file:write("\n")
                passed_commands = passed_commands + 1
            else
                log_file:write("Output:\n" .. (result or "No output") .. "\n\n")
            end

            total_commands = total_commands + 1
        end
    end

    log_file:write(passed_commands .. "/" .. total_commands .. " Tests Passed\n")
    log_file:close()
    minetest.log("All lua_object commands logged to lua_object_results.txt")
end

-- Function to run all native_object commands and log the results
-- Automated Testing
local function run_native_object_commands_and_log()
    local log_file = io.open(minetest.get_worldpath() .. "/native_object_results.txt", "w")  -- Open a text file for writing

    if not log_file then
        minetest.log("Failed to open log file for writing.")
        return
    end

    local total_commands = 0  
    local passed_commands = 0 

    for command, command_info in pairs(minetest.registered_chatcommands) do
        if string.match(command, "^native_object_") then
            minetest.log("Running native_object command: " .. command)

            local start_time = os.clock()  -- Record the start time
            local success, result = pcall(command_info.func, "singleplayer", "test")
            local end_time = os.clock()  -- Record the end time

            local execution_time = end_time - start_time  -- Calculate the execution time

            log_file:write("Command: " .. command .. "\n")
            log_file:write("Result: " .. (success and "Success" or "Error") .. "\n")
            log_file:write("Execution Time: " .. execution_time .. " seconds\n")

            if success then
                log_file:write("\n")
                passed_commands = passed_commands + 1
            else
                log_file:write("Output:\n" .. (result or "No output") .. "\n\n")
            end

            total_commands = total_commands + 1
        end
    end

    log_file:write(passed_commands .. "/" .. total_commands .. " Tests Passed\n")
    log_file:close()
    minetest.log("All native_object commands logged to native_object_results.txt")
end



-- Register a chat command to run and log lua_object commands
minetest.register_chatcommand("log_lua_object", {
    description = "Run and log lua_object commands",
    func = run_lua_object_commands_and_log,
})

-- Register a chat command to run and log native_object commands
minetest.register_chatcommand("log_native_object", {
    description = "Run and log native_object commands",
    func = run_native_object_commands_and_log,
})


--main command for logging other lua_object commands
local function run_lua_object_commands_and_log_with_time()
	-- Open a log text file to write to, and a debug text file to read from
    local log_file = io.open(minetest.get_worldpath() .. "/lua_object_results.txt", "w")
	local debug_file = io.open(minetest.get_worldpath() .. "/debug.txt", "r")

    if not log_file then
        minetest.log("Failed to open log file for writing.")
        return
    end
	if not debug_file then
		minetest.log("Failed to open debug file for reading. Please create empty debug.txt in world folder.")
		return
	end

    local total_commands = 0
    local passed_commands = 0



	--read through all old data to discard
	debug_file:read("*all")
	
	--loop through each lua_object command in the registered_chatcommands list
    for command, command_info in pairs(minetest.registered_chatcommands) do
        if string.match(command, "^lua_object") then
            minetest.log("Running lua_object command: " .. command)
			
			--record start time
			local start_time = os.clock()
			
            --calls function(name, param)
            local success, result = pcall(command_info.func, "singleplayer", "test")
			
			--record end time and calculate execution time
			local end_time = os.clock()
			local execution_time = end_time - start_time
			
            log_file:write("Command: " .. command .. "\n")
			log_file:write("Execution Time: " .. execution_time .. " seconds\n")
            log_file:write("Result: " .. (success and "Success" or "Error") .. "\n")
			log_file:write("Output:\n")
			
			--write all new data from calling the current command
			log_file:write(debug_file:read("*all"))
			
			--write result
            if (success) then
				log_file:write("\n")
                passed_commands = passed_commands + 1
            else
                log_file:write((result or "No output") .. "\n\n")
            end

            total_commands = total_commands + 1
        end
    end
	
	
	
    log_file:write(passed_commands .. "/" .. total_commands .. " Tests Passed\n")
    log_file:close()
	debug_file:close()
    minetest.log("All lua_object commands logged to lua_object_results.txt")
end

-- Register a chat command to run and log lua_object commands
minetest.register_chatcommand("log_time_lua_object", {
    description = "Run and log lua_object commands",
    func = run_lua_object_commands_and_log_with_time,
})





--main command for logging other native_object commands
local function run_native_object_commands_and_log_with_time()
	-- Open a log text file to write to, and a debug text file to read from
    local log_file = io.open(minetest.get_worldpath() .. "/native_object_results.txt", "w")
	local debug_file = io.open(minetest.get_worldpath() .. "/debug.txt", "r")

    if not log_file then
        minetest.log("Failed to open log file for writing.")
        return
    end
	if not debug_file then
		minetest.log("Failed to open debug file for reading. Please create empty debug.txt in world folder.")
		return
	end

    local total_commands = 0
    local passed_commands = 0



	--read through all old data to discard
	debug_file:read("*all")
	
	--loop through each native_object command in the registered_chatcommands list
    for command, command_info in pairs(minetest.registered_chatcommands) do
        if string.match(command, "^native_object") then
            minetest.log("Running native_object command: " .. command)
			
			--record start time
			local start_time = os.clock()
			
            --calls function(name, param)
            local success, result = pcall(command_info.func, "singleplayer", "test")
			
			--record end time and calculate execution time
			local end_time = os.clock()
			local execution_time = end_time - start_time
			
            log_file:write("Command: " .. command .. "\n")
			log_file:write("Execution Time: " .. execution_time .. " seconds\n")
            log_file:write("Result: " .. (success and "Success" or "Error") .. "\n")
			log_file:write("Output:\n")
			
			--write all new data from calling the current command
			log_file:write(debug_file:read("*all"))
			
			--write result
            if (success) then
				log_file:write("\n")
                passed_commands = passed_commands + 1
            else
                log_file:write((result or "No output") .. "\n\n")
            end

            total_commands = total_commands + 1
        end
    end
	
	
	
    log_file:write(passed_commands .. "/" .. total_commands .. " Tests Passed\n")
    log_file:close()
	debug_file:close()
    minetest.log("All native_object commands logged to native_object_results.txt")
end

-- Register a chat command to run and log native_object commands
minetest.register_chatcommand("log_time_native_object", {
    description = "Run and log native_object commands",
    func = run_native_object_commands_and_log_with_time,
})

-- Function to run commands and log execution time
local function run_commands_and_log(prefix)
    local log_file = io.open(minetest.get_worldpath() .. "/log_time.txt", "a")  -- Open a text file for appending

    if not log_file then
        minetest.log("Failed to open log file for writing.")
        return
    end

    local total_commands = 0  
    local passed_commands = 0 

    local start_time_total = os.clock()  -- Record the start time for total execution

    for command, command_info in pairs(minetest.registered_chatcommands) do
        if string.match(command, "^" .. prefix) then
            minetest.log("Running " .. prefix .. " command: " .. command)

            local start_time = os.clock()  -- Record the start time
            local success, result = pcall(command_info.func, "singleplayer", "test")
            local end_time = os.clock()  -- Record the end time

            local execution_time = end_time - start_time  -- Calculate the execution time

            if success then
                passed_commands = passed_commands + 1
            end

            total_commands = total_commands + 1
        end
    end

    local end_time_total = os.clock()  -- Record the end time for total execution
    local total_execution_time = end_time_total - start_time_total  -- Calculate the total execution time

    log_file:write("Total Execution Time for " .. prefix .. " commands: " .. total_execution_time .. " seconds\n")
    log_file:write(passed_commands .. "/" .. total_commands .. " Tests Passed\n")
    log_file:close()
    minetest.log("All " .. prefix .. " commands logged to log_time.txt")
end

-- Function to compare the execution time of lua_object and native_object commands
minetest.register_chatcommand("log_time_object", {
    description = "Run and log time comparison",
    func = function()
        minetest.after(0, function()
            run_commands_and_log("lua_object_")
        end)

        minetest.after(0, function()
            run_commands_and_log("native_object_")
        end)
    end,
})
