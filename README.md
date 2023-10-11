# Build Info Scripts

## Contents

* [About](#about)
* [Integration](#integration)
* [Authors](#authors)


## About

This repository contains scripts for generating information about the build and current ```git``` status of a project. The scripts generate string macros with information on the last ```git``` commit message, hash, date, and any changes since that commit, along with information on the build time, user, and computer.

## Integration

### CMake 

1. To generate the build info as a pre build step using CMake copy [generate_build_info.cmake](generate_build_info.cmake) into your project somewhere (ideally in a ```cmake``` folder). 
2. Use the following snippet and substitute in your target:
```cmake
add_custom_command(TARGET <your_target_here>
    PRE_BUILD
    COMMAND ${CMAKE_COMMAND} 
        -DOUTPUT_PATH=${CMAKE_CURRENT_SOURCE_DIR}
        -P ${CMAKE_SOURCE_DIR}/generate_build_info.cmake
		COMMENT "Generating build info."
    WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
)
```

### Visual Studio

1. To generate the build info as a pre build step using Visual Studio copy [generate_build_info.bat](generate_build_info.bat) into your Visual Studio project somewhere (ideally in a ```scripts``` folder). 
2. Under Project Properties->Build Events->Pre-Build Event->Command Line, paste the following command:
```bash
CALL $(SolutionDir)scripts/generate_build_info.bat
```
3. Make sure the ```build_info.h``` file is generated to a location where it can be included as a header in your project. 

## Authors

**James Horner** - James.Horner@nrc-cnrc.gc.ca or jwehorner@gmail.com
