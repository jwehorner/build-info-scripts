function(generate_build_info OUTPUT_PATH)
	execute_process(COMMAND git log --pretty=format:%ad -n 1 	OUTPUT_VARIABLE GIT_LAST_COMMIT_DATE)
	execute_process(COMMAND git log --pretty=format:%H -n 1 	OUTPUT_VARIABLE GIT_LAST_COMMIT_HASH)
	execute_process(COMMAND git log --pretty=format:%s -n 1 	OUTPUT_VARIABLE GIT_LAST_COMMIT_MESSAGE)
	execute_process(COMMAND git status -s						OUTPUT_VARIABLE GIT_CURRENT_CHANGES)
	string(REGEX REPLACE "\n" " " GIT_CURRENT_CHANGES "${GIT_CURRENT_CHANGES}")

	string(TIMESTAMP BUILD_CURRENT_TIME)
	set(BUILD_CURRENT_USER "$ENV{USERNAME}")
	cmake_host_system_information(RESULT BUILD_CURRENT_HOSTNAME QUERY HOSTNAME)

	file(WRITE 
		"${OUTPUT_PATH}/build_info.h"
"#ifndef BUILD_INFO_H
#define BUILD_INFO_H

#define GIT_LAST_COMMIT_DATE    \"${GIT_LAST_COMMIT_DATE}\"
#define GIT_LAST_COMMIT_HASH    \"${GIT_LAST_COMMIT_HASH}\"
#define GIT_LAST_COMMIT_MESSAGE \"${GIT_LAST_COMMIT_MESSAGE}\"
#define GIT_CURRENT_CHANGES     \"${GIT_CURRENT_CHANGES}\"
#define BUILD_CURRENT_TIME      \"${BUILD_CURRENT_TIME}\"
#define BUILD_CURRENT_USER      \"${BUILD_CURRENT_USER}\"
#define BUILD_CURRENT_HOSTNAME  \"${BUILD_CURRENT_HOSTNAME}\"

#endif /* BUILD_INFO_H */"
	)
	message("Build info written to: ${OUTPUT_PATH}/build_info.h")
endfunction()

generate_build_info("${OUTPUT_PATH}")