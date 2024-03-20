minetest.register_alias("sean_ferguson", "sean_ferguson:sean_ferguson_block")
 
minetest.register_node("sean_ferguson:sean_ferguson_block", {
    description = "Sean block",
    -- Make it able to be broken by hand.
    groups = {oddly_breakable_by_hand = 2},
    -- Set it's tile faces to the png that you have in the 'textures' folder.
    tiles = {"sean_ferguson_block.png"},
    -- Make it able to be placed on the ground.
    is_ground_content = true,
    -- Make sure that the inventory image is visible too :)
    -- This step isn't COMPLETELY necessary, and you could use other minetest inventory visualization functions if you want to.
    inventory_image = minetest.inventorycube("sean_ferguson_block.png", "sean_ferguson_block.png", "sean_ferguson_block.png"),
})
 
-- This step is creating a way for a user to craft this block.
minetest.register_craft({
    -- Output is just '[alias] [number of returned blocks from crafting]'
    output = 'sean_ferguson:sean_ferguson_block 5',
    -- Recipe is a 3x3 grid. 
    -- Note: Make sure you have the 'default:' prefix!
    recipe = {
        {'default:stone', '', ''},
        {'default:stone', '', ''},
        {'default:stone', 'default:stone', 'default:stone'},
    }
})