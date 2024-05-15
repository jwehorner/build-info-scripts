function(generate_build_info OUTPUT_PATH)
	# Retrieve the current Git and build status and store it into single line strings.
	execute_process(COMMAND git log --pretty=format:%ad -n 1 	OUTPUT_VARIABLE GIT_LAST_COMMIT_DATE)
	execute_process(COMMAND git log --pretty=format:%H -n 1 	OUTPUT_VARIABLE GIT_LAST_COMMIT_HASH)
	execute_process(COMMAND git log --pretty=format:%s -n 1 	OUTPUT_VARIABLE GIT_LAST_COMMIT_MESSAGE)
	execute_process(COMMAND git status -s						OUTPUT_VARIABLE GIT_CURRENT_CHANGES)
	execute_process(COMMAND git branch --show-current			OUTPUT_VARIABLE GIT_CURRENT_BRANCH)

	string(TIMESTAMP BUILD_CURRENT_TIME)
	set(BUILD_CURRENT_USER "$ENV{USERNAME}")
	cmake_host_system_information(RESULT BUILD_CURRENT_HOSTNAME QUERY HOSTNAME)

	# Process the strings to remove any characters that might break a C string.
	string(REGEX REPLACE "\n" " "   GIT_LAST_COMMIT_DATE      "${GIT_LAST_COMMIT_DATE}")
	string(REGEX REPLACE "\"" ""    GIT_LAST_COMMIT_DATE      "${GIT_LAST_COMMIT_DATE}")
	string(REGEX REPLACE "\\\\" "/" GIT_LAST_COMMIT_DATE      "${GIT_LAST_COMMIT_DATE}")

	string(REGEX REPLACE "\n" " "   GIT_LAST_COMMIT_HASH      "${GIT_LAST_COMMIT_HASH}")
	string(REGEX REPLACE "\"" ""    GIT_LAST_COMMIT_HASH      "${GIT_LAST_COMMIT_HASH}")
	string(REGEX REPLACE "\\\\" "/" GIT_LAST_COMMIT_HASH      "${GIT_LAST_COMMIT_HASH}")

	string(REGEX REPLACE "\n" " "   GIT_LAST_COMMIT_MESSAGE   "${GIT_LAST_COMMIT_MESSAGE}")
	string(REGEX REPLACE "\"" ""    GIT_LAST_COMMIT_MESSAGE   "${GIT_LAST_COMMIT_MESSAGE}")
	string(REGEX REPLACE "\\\\" "/" GIT_LAST_COMMIT_MESSAGE   "${GIT_LAST_COMMIT_MESSAGE}")

	string(REGEX REPLACE "\n" " "   GIT_CURRENT_CHANGES       "${GIT_CURRENT_CHANGES}")
	string(REGEX REPLACE "\"" ""    GIT_CURRENT_CHANGES       "${GIT_CURRENT_CHANGES}")
	string(REGEX REPLACE "\\\\" "/" GIT_CURRENT_CHANGES       "${GIT_CURRENT_CHANGES}")

	string(REGEX REPLACE "\n" ""    GIT_CURRENT_BRANCH        "${GIT_CURRENT_BRANCH}")
	string(REGEX REPLACE "\"" ""    GIT_CURRENT_BRANCH        "${GIT_CURRENT_BRANCH}")
	string(REGEX REPLACE "\\\\" "/" GIT_CURRENT_BRANCH        "${GIT_CURRENT_BRANCH}")

	string(REGEX REPLACE "\n" ""    BUILD_CURRENT_TIME        "${BUILD_CURRENT_TIME}")
	string(REGEX REPLACE "\"" ""    BUILD_CURRENT_TIME        "${BUILD_CURRENT_TIME}")
	string(REGEX REPLACE "\\\\" "/" BUILD_CURRENT_TIME        "${BUILD_CURRENT_TIME}")

	string(REGEX REPLACE "\n" ""    BUILD_CURRENT_USER        "${BUILD_CURRENT_USER}")
	string(REGEX REPLACE "\"" ""    BUILD_CURRENT_USER        "${BUILD_CURRENT_USER}")
	string(REGEX REPLACE "\\\\" "/" BUILD_CURRENT_USER        "${BUILD_CURRENT_USER}")

	string(REGEX REPLACE "\n" ""    BUILD_CURRENT_HOSTNAME    "${BUILD_CURRENT_HOSTNAME}")
	string(REGEX REPLACE "\"" ""    BUILD_CURRENT_HOSTNAME    "${BUILD_CURRENT_HOSTNAME}")
	string(REGEX REPLACE "\\\\" "/" BUILD_CURRENT_HOSTNAME    "${BUILD_CURRENT_HOSTNAME}")

	# Write the strings to the output file.
	file(WRITE 
		"${OUTPUT_PATH}/build_info.h"
"#ifndef BUILD_INFO_H
#define BUILD_INFO_H

#define GIT_LAST_COMMIT_DATE    \"${GIT_LAST_COMMIT_DATE}\"
#define GIT_LAST_COMMIT_HASH    \"${GIT_LAST_COMMIT_HASH}\"
#define GIT_LAST_COMMIT_MESSAGE \"${GIT_LAST_COMMIT_MESSAGE}\"
#define GIT_CURRENT_CHANGES     \"${GIT_CURRENT_CHANGES}\"
#define GIT_CURRENT_BRANCH      \"${GIT_CURRENT_BRANCH}\"
#define BUILD_CURRENT_TIME      \"${BUILD_CURRENT_TIME}\"
#define BUILD_CURRENT_USER      \"${BUILD_CURRENT_USER}\"
#define BUILD_CURRENT_HOSTNAME  \"${BUILD_CURRENT_HOSTNAME}\"

#endif /* BUILD_INFO_H */"
	)
	message("Build info written to: ${OUTPUT_PATH}/build_info.h")
endfunction()

generate_build_info("${OUTPUT_PATH}")