cmake_minimum_required(VERSION 3.20 FATAL_ERROR)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED True)

project(GenerateBuildInfo)
get_filename_component(SCRIPTS_DIRECTORY "../scripts" ABSOLUTE)

###########################
###  Targte Definition  ###
###########################
add_custom_target(test)
add_custom_command(TARGET test
    PRE_BUILD
    COMMAND ${CMAKE_COMMAND} 
        -DOUTPUT_PATH=${SCRIPTS_DIRECTORY}
        -P ${SCRIPTS_DIRECTORY}/generate_build_info.cmake
		COMMENT "Generating build info."
    WORKING_DIRECTORY ${SCRIPTS_DIRECTORY}
)