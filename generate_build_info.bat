@echo off
setlocal enabledelayedexpansion
(
	git log --pretty=format:"#define GIT_LAST_COMMIT_DATE    \"%%ad\"%%n#define GIT_LAST_COMMIT_HASH    \"%%H\"%%n#define GIT_LAST_COMMIT_MESSAGE \"%%s\" %%n" -n 1
)> build_info.h
set status_text=
set row=
for /F "tokens=*" %%x in ('git status -s') do set "row=!row! %%x"
set status_text=%status_text% %row%
(
	echo #define GIT_CURRENT_CHANGES		"%status_text%"
)>> build_info.h
(
	echo #define CURRENT_BUILD_TIME 		"%DATE%%TIME%"
)>> build_info.h
(
	echo #define CURRENT_BUILD_USER		"%USERNAME%"
)>> build_info.h
(
	echo #define CURRENT_BUILD_COMPUTER	"%COMPUTERNAME%"
)>> build_info.h