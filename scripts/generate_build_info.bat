@echo off
setlocal enabledelayedexpansion

@REM Retrieve the current Git and build status and store it into single line strings.
set GIT_LAST_COMMIT_DATE=
for /F "tokens=*" %%x in ('git log --pretty^=format:%%ad -n 1') do set GIT_LAST_COMMIT_DATE=%%x

set GIT_LAST_COMMIT_HASH=
for /F "tokens=*" %%x in ('git log --pretty^=format:%%H -n 1') do set GIT_LAST_COMMIT_HASH=%%x

set GIT_LAST_COMMIT_MESSAGE=
set row=
for /F "tokens=*" %%x in ('git log --pretty^=format:%%s -n 1') do set "row=!row! %%x"
	set GIT_LAST_COMMIT_MESSAGE=%GIT_LAST_COMMIT_MESSAGE%%row%

set GIT_CURRENT_CHANGES=
set row=
for /F "tokens=*" %%x in ('git status -s') do set "row=!row! %%x"
	set GIT_CURRENT_CHANGES=%GIT_CURRENT_CHANGES%%row%

set GIT_CURRENT_BRANCH=
set row=
FOR /F "tokens=*" %%x in ('git branch --show-current') do set "row=!row!%%x"
	set GIT_CURRENT_BRANCH=%GIT_CURRENT_BRANCH%%row%

set BUILD_CURRENT_TIME=%DATE%%TIME%
set BUILD_CURRENT_USER=%USERNAME%
set BUILD_CURRENT_HOSTNAME=%COMPUTERNAME%


@REM Process the strings to remove any characters that might break a C string.
set GIT_LAST_COMMIT_DATE=!GIT_LAST_COMMIT_DATE:"=!
set GIT_LAST_COMMIT_DATE=!GIT_LAST_COMMIT_DATE:\=/!

set GIT_LAST_COMMIT_HASH=!GIT_LAST_COMMIT_HASH:"=!
set GIT_LAST_COMMIT_HASH=!GIT_LAST_COMMIT_HASH:\=/!

set GIT_LAST_COMMIT_MESSAGE=!GIT_LAST_COMMIT_MESSAGE:"=!
set GIT_LAST_COMMIT_MESSAGE=!GIT_LAST_COMMIT_MESSAGE:\=/!

set GIT_CURRENT_CHANGES=!GIT_CURRENT_CHANGES:"=!
set GIT_CURRENT_CHANGES=!GIT_CURRENT_CHANGES:\=/!

set GIT_CURRENT_BRANCH=!GIT_CURRENT_BRANCH:"=!
set GIT_CURRENT_BRANCH=!GIT_CURRENT_BRANCH:\=/!

set BUILD_CURRENT_TIME=!BUILD_CURRENT_TIME:"=!
set BUILD_CURRENT_TIME=!BUILD_CURRENT_TIME:\=/!

set BUILD_CURRENT_USER=!BUILD_CURRENT_USER:"=!
set BUILD_CURRENT_USER=!BUILD_CURRENT_USER:\=/!

set BUILD_CURRENT_HOSTNAME=!BUILD_CURRENT_HOSTNAME:"=!
set BUILD_CURRENT_HOSTNAME=!BUILD_CURRENT_HOSTNAME:\=/!


@REM Write the strings to the output file.
(echo #ifndef BUILD_INFO_H) > build_info.h
(echo #define BUILD_INFO_H) >> build_info.h
(echo.) >> build_info.h

(echo #define GIT_LAST_COMMIT_DATE      "%GIT_LAST_COMMIT_DATE%") 	  >> build_info.h
(echo #define GIT_LAST_COMMIT_HASH      "%GIT_LAST_COMMIT_HASH%") 	  >> build_info.h
(echo #define GIT_LAST_COMMIT_MESSAGE   "%GIT_LAST_COMMIT_MESSAGE%")  >> build_info.h
(echo #define GIT_CURRENT_CHANGES       "%GIT_CURRENT_CHANGES%")      >> build_info.h
(echo #define GIT_CURRENT_BRANCH        "%GIT_CURRENT_BRANCH%")       >> build_info.h
(echo #define BUILD_CURRENT_TIME        "%BUILD_CURRENT_TIME%")       >> build_info.h
(echo #define BUILD_CURRENT_USER        "%BUILD_CURRENT_USER%")       >> build_info.h
(echo #define BUILD_CURRENT_HOSTNAME    "%BUILD_CURRENT_HOSTNAME%")   >> build_info.h

(echo.) >> build_info.h
(echo #endif /* BUILD_INFO_H */) >> build_info.h