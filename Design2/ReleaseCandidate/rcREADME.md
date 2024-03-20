# Release Candidate for Minetest
## Overview:
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Minecraft's adaptability, cost-effectiveness, and engaging gameplay have garnered interest from various individuals, leading to its application in educational settings. Minetest, an open-source counterpart to Minecraft, plays a significant role in helping individuals develop coding skills. As a sandbox game, Minetest offers a dynamic and interactive environment that enhances students' creativity, problem-solving, and collaboration skills. The game provides a customizable platform, enabling educators to design and tailor educational content such as the customization of facilities, land, and environment. This platform also addresses specific learning objectives and individual students' needs. The flexibility of Minetest is particularly advantageous when incorporating it into a wide range of STEM field subjects. Its open-source nature ensures free access for all schools, eliminating financial barriers that might exist with commercial alternatives. By integrating Minetest into the classroom, educators can offer a dynamic, immersive learning experience that promotes self-directed exploration, critical thinking, and real-world applications of subject matter [1]. Consequently, teachers can effectively bridge the gap between traditional teaching methods and the rapidly evolving world of digital technologies, better preparing students for the challenges and opportunities they will encounter in the 21st century.
\
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Minetest will play a significant role when it's incorporated into an educational setting. Also, the proven results illustrate that Minetest fosters creativity, problem-solving, and collaboration among students. Nevertheless, a significant challenge arises for both educators and students on the games’ dependence on Lua scripts which may lead to unfamiliarity for students to code and edit since the Lua script is ranked 30th in coding languages [2]. To tackle this issue, the minetest team is working on recreating the Lua game engine in C++. Our Design 2 team is currently focused on salvaging as much C++ code as possible, so when the team starts coding the game engine, less time will be spent on redeveloping code. As we know, C++ is a widely acknowledged programming language, iterating and modifying the game with new C++ files not only streamlines the learning process for students but also broadens the accessibility of Minetest as an educational tool. By bridging the gap between Lua and C++, our team ensures that students can effectively engage with Minetest's educational content without the necessity to invest time in learning Lua scripting and potentially being able to code in their language of choice. This improvement will ultimately enhance the overall learning experience and empower students to concentrate on critical thinking, problem-solving, and collaboration skills essential for success in the classroom.
\
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Following in the footsteps of the previous team we found that in order to optimize the process of rewriting Minetest functions, our team will partition the work into distinct classes, each comprising one or multiple functions that interact with the Lua script functions. To guarantee the effectiveness and accuracy of the rewritten functions, our team has incorporated a three-stage process for each member to follow. The initial stage, "written," entails creating and registering Native API functions in the corresponding Lua bound C files. In the subsequent stage, "compile," team members draft chat commands for each Native API function, invoking them and ensuring they can be compiled and executed without errors or yielding nil values. The final stage, "test," concentrates on verifying the accuracy of the rewritten functions by crafting chat commands for each Native API function and comparing the outcomes with the corresponding Lua API function. Should any discrepancies emerge, the Native API function is adjusted to maintain consistency with the Lua function. This systematic based on Cacti Council’s approach enables our team to effectively rewrite and validate the new C++ functions while preserving the integrity of the original Minetest functions, ultimately improving the game's accessibility and educational value for students.

## Usability:
**Interface**
Testing functions should have an intuitive naming convention, i.e. l_object.cpp function name l_set_pos should be called through “/lua_object_set_pos”. Outputs from the testing data will output to the console command. We've created automated logging systems that time responsiveness of functions and output necessary debugging information for ease of testing.

**Navigation**
When testing, error messages will be created based on unexpected results being fed to the testing functions. Using logs, such as “minetest.logs(“output error message here”..variable)” should be used wherever possible. The logging method also gives line number error code responses without crashing the game as running the code normally would.

**Perception**
The Final Product delivered should maintain the same standard of gameplay while allowing users to interact with the modding section under easier circumstances. The rewriting of the game engine is expected to run at the same speed as the Lua counterpart. Testing should be intuitive and the game should operate similarly to Minetest's current state when the native functions are implemented. To ensure this we added the function operation time testing in logging method.

**Responsiveness**
When recreating the functions, if there is a noticeable difference in FPS check for recursive errors. Otherwise, note the changes and bring up issues with the team. The expected output of our program is to minimize FPS changes comparatively to the original build. 

## Build Quality:
**Robustness**
Crashes should not occur during regular, unexceptional use of the application. Major or noticeable glitches should be absent from the regular user experience within the master build. Any noticeable bugs should be noted in logs and fixed as soon as possible, or noted in the work-in-progress functions. Actual FPS tests are not currently implemented but have been brought up in team meetings.

**Consistency**
The application should consistently produce the same result for the same input and use cases. Any deviations from predictability should have clear and justified reasons. All methods for recreating our steps have been documented and can be found in the "CactiCouncil" file directory. 

**Aethsteic Rigor**
All in-game assets should be reused from the original source code. Aesthetic issues, if present, should not render the game unplayable, and all assets such as images and sounds should be functional.
## Vertical Features:
**External Interface *(Console/Chat)***
Mods are called in the game and logs of actions in the game are output to a console where full crash reports, mod outputs, and chatlogs are referenced.

**Persistant State *(Mod Code)***
Each Lua function must incorporate three test functions in the final product. When interfacing with the game, one of these three test functions will be referenced, and the other two and compared to their pushed lua dumps.

**Internal Systems *(Source Code)***
All Lua systems in the game will be swapped with our Native functions. The testing will ensure a seamless and lossless transition between the old and new game engines. 

# Outline of Release Candidate Work
Release Candidate Team Video: https://youtu.be/dlU3AWa-2MA

## Week 1 (10/7 - 10/13)
This week there was a shift from the normal workflow. The team wanted to transition into more of a tool-based and documentation approach rather than function development. log_lua and log_native were our first steps into automation and allowed for all scripts beginning in lua_object and native_object to be run and their outputs to a log file.

### Sean - Added Functions:
* native_object_remove
* native_object_get_pos
* lua_object_send_mapblock
* log_lua_object
* log_native_object

### Chris - Added Functions:
* native_object_get_look_dir
* native_object_get_look_pitch
* native_object_get_look_yaw
* native_object_get_look_vertical
* native_object_get_look_vertical
* lua_object_get_look_dir
* lua_object_get_look_pitch
* lua_object_get_look_yaw
* lua_object_get_look_vertical
* lua_object_get_look_vertical

## Week 2 (10/14 - 10/20)
Lots of collaboration with the entire CactiCouncil team. Onboarded our newest member Alice with mod creation and tasked her with finding new automation techniques and helped Erik in class debugging issues. Made sure automated testing worked with all functions. Consolidated more GitHubs and gave push permissions to all members.

### Sean - Added Functions:
* native_object_get_pos
* native_object_set_pos
* native_object_move_to
* native_object_set_hp
* native_object_get_hp

### Chris - Added Functions:
* lua_object_get_entity_name
* lua_object_get_luaentity
* lua_object_get_player_name
* lua_object_override_day_night_ratio
* lua_object_get_day_night_ratio

## Week 3 (10/21 - 10/27)
Added timing capabilities to the logging system and started creating tutorials for our work so future members can view the work that we do.

### Sean - Edited Functions:
* log_lua_object
* log_native_object

### Chris - Added Functions:
* lua_object_hud_add
* lua_object_hud_remove
* lua_object_hud_change
* lua_object_get

## Week 4 (10/28 - 11/3)
Finished up tutorials and figured out how to output debug text in the logging files. Started adding default "test" param to previously completed functions to test valid input parameters rather than just an integer param.

### Sean - Edited Functions:
* log_lua_object
* log_native_object

### Chris - Added Functions:
* lua_object_hud_set_hotbar_itemcount
* lua_object_hud_get_hotbar_itemcount
* lua_object_hud_get_hotbar_image
* lua_object_hud_set_hotbar_image

## Known Bugs/Issues
* Logging requires editing of main.cpp and the file location of debug.txt. This is only an issue because it needs to be located in the world file to interact with the log command. This means that the world name must be hard-coded into the debug directory.
* ~~Native Tests - Not working, Linker error, new functions unrecognized~~
* ~~Set HP - Unknown Input Params~~
* Punch - Unknown Input Params (self, puncher, time from last punch, tool capabilities, direction)
* Set Animation - Unknown Input Params (self, frame_range, frame_speed, frame_blend, frame_loop)
* Set Local Animation - Unknown Input Params (self, idle, walk, dig, walk_while_dig, frame_speed)
* Send Mapblock - Unknown test trigger
* Set Sun - Input Param too Long (self, sun_paramters)
* Set Moon - Input Param too Long (self, moon_paramters)
* ~~Customized Pictures - Where to store/link custom images~~

## Important Links:
- Minetest Native API Github: [https://github.com/cacticouncil/minetest](https://github.com/cacticouncil/minetest/tree/native-api)
- Design 2 Object's Class Checklist: https://docs.google.com/spreadsheets/d/1PM4jhVm7i4OwgGq1aDPfn8IWj7l7l0uh8i5fXMeRUhU/edit?usp=sharing
- Design 2 Working Branch: https://github.com/sferguson32155/minetest/tree/sean-test-branch
- Songyuhao Shi - Work Log: https://docs.google.com/spreadsheets/d/1qtSN0sl43u4A3n5VJuM3343Ox1RSD6h2bfjfHH4yiok/edit?usp=sharing
- Release Candidate Team Video: https://youtu.be/dlU3AWa-2MA


## Citations
[1] Noelene Callaghan (2016) Investigating the role of Minecraft in educational learning environments, Educational Media International, 53:4, 244-260, DOI: 10.1080/09523987.2016.1254877  
[2] Tiobe index. TIOBE. (2022, June 3). Retrieved April 25, 2023, from https://www.tiobe.com/tiobe-index/
