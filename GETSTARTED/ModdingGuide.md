Minetest Modding Guide
=========================

Contents
--------
1. [Making a Simple Mod](#1-making-a-simple-mod)
2. [Making a WASM Mod](#2-making-a-wasm-mod)
3. [Manually Compiling Your WASM from C (Reference)](#3-manually-compiling-your-wasm-from-c-reference)
4. [Important Notes](#4-important-notes)

**Made for use by the Cacti Council**

**Written by: Luke Herczeg**

**Adapted by: [Logan D.G. Smith](https://github.com/logandgsmith)**

## 1. Making a Simple Mod

### Elements of a Basic Mod
We will be making a mod in the ‘minimal’ folder. You can make a new folder inside that one, and call it whatever you like!

Example Path: `C:\Users\<your_username>\DIR\minetest\games\minimal\mods\<mod_folder>`

In this folder, you will add the following files:

#### I. init.lua

This file is what drives basic mods. It registers and defines new blocks or behaviors for the game to implement. 

```lua
-- LukeWasHere block (A Luke test mod)
-- A block which does absolutely nothing.
 
-- The second parameter is the block alias, which doesn't have any connection to the mod folder name.
-- The first parameter does, however, need to be IDENTICAL to your mod.conf 'name' string.
minetest.register_alias("luke_was_here", "luke_was_here:luke_was_here_block")
 
-- This block now must be registered, with the alias as it's first parameter.
minetest.register_node("luke_was_here:luke_was_here_block", {
    description = "Luke block",
    -- Make it able to be broken by hand.
    groups = {oddly_breakable_by_hand = 2},
    -- Set it's tile faces to the png that you have in the 'textures' folder.
    tiles = {"LukeWasHere.png"},
    -- Make it able to be placed on the ground.
    is_ground_content = true,
    -- Make sure that the inventory image is visible too :)
    -- This step isn't COMPLETELY necessary, and you could use other minetest inventory visualization functions if you want to.
    inventory_image = minetest.inventorycube("LukeWasHere.png", "LukeWasHere.png", "LukeWasHere.png"),
})
 
-- This step is creating a way for a user to craft this block.
minetest.register_craft({
    -- Output is just '[alias] [number of returned blocks from crafting]'
    output = 'luke_was_here:luke_was_here_block 1',
    -- Recipe is a 3x3 grid. 
    -- Note: Make sure you have the 'default:' prefix!
    recipe = {
        {'default:wood', '', ''},
        {'default:wood', '', ''},
        {'default:wood', 'default:wood', ''},
    }
})
```

#### II. mod.conf

This file just prepares a few basic settings for the mod. Here is mine:

```
name = luke_was_here
description = Adding LukeWasHere block.
Depends = default
```

#### III. textures (folder)

  * #### YourBlockPic.png
    * Just make or find a png file and put it in this folder. 
      Give it whatever name you like! :)

That’s all you should need! Just run the game in minimal mode, create your block with the material you require 
and the recipe shape you defined, and you will see your block in game, and you should be able to place it and 
destroy it at will!

## 2. Making a WASM Mod

Though there are similarities to a normal mod, a WASM mod has some new automations built in.
For this, go ahead and take your original mod folder and copy over the textures folder, and use a different .png file 
as the block, so you can be sure when your WASM mod is working. You’ll only need to made a new mod.conf and a mod.c.

#### I. init.lua
  * **This file is now generated for you**, however, if you'd like to edit it afterwards, here is the structure:
```lua
-- LukeWasHere block (A Luke test mod)
-- A block which does absolutely nothing.
 
 
function register_wasm_mod(name, description, texture, material)
    minetest.register_node(":" .. name, {
        description = description,
        groups = {oddly_breakable_by_hand=2},
        tiles = {texture},
    })
 
    -- I register my craft as an 'L' shape for fun, since it's a Luke block!
    minetest.register_craft({
        output = name,
        recipe = {
            {material, '', ''},
            {material, '', ''},
            {material, material, ''},
        },
    })
end
```

#### II. mod.c
  * **This will NOT be generated for you**.
  * This is our mod file (in the future, this would potentially be written in any language, but for now we use C). 
    It contains the functions we want our WASM file to export (which our mod.js file will then read). 
    I know there are a lot of steps and interconnected elements here, but bear with me! 
    
```c
char * getName() {
    return "luke_mod_wasm";
}
 
char * getDescription() {
    return "Simple Luke Wasm Mod";
}
 
char * getTexture() {
    return "LukeWasmHere.png";
}
 
char * getMaterial() {
    return "default:wood";
}
```

#### III. mod.conf
  * **This will NOT be generated for you**
  * This is ALMOST identical to the version used for a simple mod. Only one line is added; ‘wasm = yes’.

```
name = luke_mod_wasm
description = Adding LukeWasHere block.
depends = default
wasm = yes
```

#### IV. mod.wasm
  * **This will be automatically generated from Section 3 of this document**
  * It cannot be edited, and it is just a binary file created from compilation. However, it can be viewed with the VS Code 
    Webassembly Extension. (Side note; I highly recommend using VS Code for editing and viewing all the mod-related files.)
    Using that extension, you should see something that looks VERY SIMILAR to this after you finish Section 4:
    
    < Pic Soon >
    
#### V. mod.js
  * **This file is automatically generated for you**
  * It is the glue that reads the `mod.wasm` file.

```js
function utf8ToString(mem, pos) {
    let s = "";
    for (i = pos; mem[i]; i++) {
        s += String.fromCharCode(mem[i]);
    }
    return s;
}
 
var buffer = new Uint8Array(%wbC:\Users\Steve\DIR\minetest\games\minimal\mods\luke_mod_wasm\mod.wasmwb%);
var m = new WebAssembly.Instance(new WebAssembly.Module(buffer));
var memArray = new Uint8Array(m.exports.memory.buffer);
var ex = m.exports;
 
var modInfo = {
    name: utf8ToString(memArray, ex.getName()),
    description: utf8ToString(memArray, ex.getDescription()),
    texture: utf8ToString(memArray, ex.getTexture()),
    material: utf8ToString(memArray, ex.getMaterial()),
}
 
function getMod(mod) {
    return mod;
}
 
getMod(modInfo);
```

#### textures (folder
  * #### YourBlockPic.png
    * Same as before! Just make or find a png file and put it in this folder. 
      Give it whatever name you like! :)
      
## 3. Manually Compiling Your WASM from C (Reference)

**NOTE: This section is now performed automatically. If you need to carry it out manually, please follow the following steps.**

#### I. Clone the emscripten sdk

I suggest you clone it to `C:\Users\<your_username>\DIR\`

`git clone https://github.com/emscripten-core/emsdk.git`

#### II. Navigate to the directory

`cd emsdk`

#### III. Activation and Compilation

**NOTE: The next steps depend on whether or not you can use Powershell or Command Prompt. (They are both step 3! Do only one of the two options!)
  If the Powershell method does not work for you, please attempt to follow the Command Prompt method.**
  
##### Instructions for Windows Powershell

  1. Install the correct version of the SDK
 
```bash
git pull
./emsdk install 2.0.1
./emsdk activate 2.0.1
Emsdk_env.bat
```

  2. Go to the mod directory, make sure there is not another mod.wasm file, and run the following command (this is one line):
  
    `emcc mod.c -o mod.wasm -Os -s EXPORTED_FUNCTIONS='["_getName", "_getDescription", "_getTexture", "_getMaterial"]'
    
  3. Run the game!

##### Instructions for Command Prompt (cmd)

  1. Install the correct version of the SDK
 
```bash
git pull
./emsdk install 2.0.1
./emsdk activate 2.0.1
emsdk_env.bat
```

  2. Go to the mod directory, make sure there is not another mod.wasm file, and run the following command (this is one line):
  
    `emcc mod.c -o mod.wasm -Os -s "EXPORTED_FUNCTIONS=["_getName", "_getDescription", "_getTexture", "_getMaterial"]"'
    
  3. Run the game!

The rest of the official setup guide for Emscripten can be found here: 
https://emscripten.org/docs/getting_started/downloads.html

## 4. Important Notes

1. You can only have one WASM mod folder in your ‘mods’ folder at a time.
2. Each time you open a new emsdk terminal window, you have to reactivate the correct emsdk environment by 
   running the following:
    * `emsdk activate 2.0.1`
    * `emsdk_env.bat`
