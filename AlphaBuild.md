# Alpha Build for Minetest
## Usability:
**Interface**
Testing functions should have an intuitive naming convention, i.e l_object.cpp function name l_set_pos should be called through “/lua_object_set_pos”. Outputs from the testing data will output to the console command.

**Navigation**
When testing, error messages will be created based on unexpected results being fed to the testing functions. Using logs, such as “minetest.logs(“output error message here”..variable)” should be used where ever possible.

**Perception**
Final product should interact with the player as seamlessly and easily as possible. Testing should be intuitive and the game should operate similarly to Minetest if not exactly the same.

**Responsiveness**
When rendering the game, any noticeable FPS drops should be noted and fixed as soon as possible. The game should handle operations that involve significant input/output (I/O) operations efficiently, without causing the CPU to wait idly.

## Build Quality:
**Robustness**
Crashes should not occur during regular, unexceptional use of the application. Major or noticeable glitches should be absent from the regular user experience within the master build. Any noticeable bugs should be noted in logs and fixed as soon as possible, or noted in the work in progress functions.

**Consistency**
The application should consistently produce the same result for the same input and use cases. Any deviations from predictability should have clear and justified reasons.

**Aethsteic Rigor**
All ingame assets should be reused from the original source code. Aesthetic issues, if present, should not render the game unplayable, and all assets such as images and sounds should be functional.
## Vertical Features:
**External Interface *(Console/Chat)***
Mods are called in game and logs of actions in the game are output to a console where full crash reports, mod outputs, and chatlogs are referenced.

**Persistant State *(Mod Code)***
Each Lua function must incorporate three test function in the final product. When interfacing the game, one of these three test functions will be referenced and call the other two and compare their pushed lua dumps.

**Internal Systems *(Source Code)***
All Lua systems in the game will be swapped with our Native functions. The testing will ensure seemless and lossless transition between the old and new game engines. 
## Important Links:
- Minetest Native API Github: https://github.com/cacticouncil/minetest
- Minetest Native Installation Guide and Files: https://github.com/Lisa-Touchton-DEV/MinetestDocs
- Sean Ferguson - Work Log: https://github.com/sferguson32155/minetestlogs
- Sean Ferguson - Working Branch: https://github.com/sferguson32155/minetest/tree/sean-test-branch
- Songyuhao Shi - Work Log: https://github.com/sf1440/CEN3907Logs
- Songyuhao Shi - Working Branch: https://github.com/sf1440/Minetest

