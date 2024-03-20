# Beta Test Plan
## Overview:
### Where to Start:
To begin with the installation of our Minetest build follow the documentation given in the Minetest installation guide:

* Minetest Native Installation Guide and Files: https://github.com/Lisa-Touchton-DEV/MinetestDocs

After you have successfully installed the native build of minetest onto your local device, load the sean-test-branch listed in the bottom right branches.

## Alpha Test Results:
### Issues Identified
#### Native Functions 
* Were not linking to the project correctly
* Had to be instantiated at the bottom of the object.cpp file
* Header file dependencies had to be evaluated as the file path had changed
#### Lua Test Functions
* Input parameters had to be solved in order to test (Unsolved functions: set_hp, punch, etc. see Known Bugs in BetaREADME.md)
* Some functions need specific actions to occur to trigger (Ex: send_mapblock)
* Deprecated functions, set_look_yaw, and set_look_pitch, showed inconsistencies in the game's player orientation.
* Some functions require custom image specifications and file paths which have yet to be identified.
#### Documentation
* Documentation was under expected results for Design 2
* Code changes not uploaded the same day of the change
* Messy and unorganized reporting
### Changes Made
#### Native Functions
* Native test development has begun as Erik was able to assist the Design 2 team with linker errors
#### Lua Test Functions
* Created automated testing for Lua Functions (will implement this for native and test when more testing is completed)
#### Documentation
* Consolidated Sean and Chris' GitHub
* Created better documentation templates
* Upload code the day of, or soon after, for timeline accuracy
### Impact on Beta Test Plan
Greater emphasis on documentation and native testing moving forward. All test types have been completed so the development of tests should be easier as reference material has been made. A default input param "0" will be created for automated test purposes for the complicated input parameters such as set_sky and set_sun etc.

## Expected Behavior:
### Check List / Function Claim
* Function List where documentation for functions' expected results can be found
  * https://doxy.minetest.net/classObjectRef.html
  * Use this to compare testing results to ensure test functions work properly
* Object Check List
  * https://docs.google.com/spreadsheets/d/1PM4jhVm7i4OwgGq1aDPfn8IWj7l7l0uh8i5fXMeRUhU/edit#gid=0
  * Claim functions and view the completion percentage of the project
  * For team members' use only
### Source Code
* Source code changes can be found on either sean-test-branch (main design 2 build) or TrackingForMinetest
  * Design 2 Main Branch: https://github.com/sferguson32155/minetest/tree/sean-test-branch
  * Deisgn 2 Test Branch: https://github.com/sf1440/TrackingForMinetest
### Work Logs
* Work Logs contain time and date information as well as bugs and their found solutions
  * Sean's Work Logs: https://github.com/sferguson32155/minetest/tree/sean-test-branch/sean-logs
  * Chris' Work Logs: https://docs.google.com/spreadsheets/d/1qtSN0sl43u4A3n5VJuM3343Ox1RSD6h2bfjfHH4yiok/edit#gid=0

## Test Procedures:
### Function Testing
* Lua Function Testing
  * Execute each Lua function and document its behavior
  * Verify its consistency across different game scenarios
  * Compare results to Minetest Wiki
* Native Function Testing
  * Execute the corresponding C++ function for each Lua function tested
  * Compare results with the Lua version to ensure they match
* Test Function Testing
  * Final testing type for each function
  * Deep comparison between native and lua testing functions running side-by-side
  * ALL outputs of both Lua and Native MUST match to pass
### Server Debug
* All commands issued are output to debug.txt, which stores a comprehensive console of all commands run on your local machine
* Use this to get example outputs for logging
### Automated Lua Testing
* Automating testing allows for custom player types and input params
* Runs all lua_object tests and prints errors wherever found
