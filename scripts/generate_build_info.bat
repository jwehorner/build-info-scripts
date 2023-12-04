@echo off
setlocal enabledelayedexpansion

(echo #ifndef BUILD_INFO_H) > build_info.h
(echo #define BUILD_INFO_H) >> build_info.h
(echo.) >> build_info.h

set git_log_format="#define GIT_LAST_COMMIT_DATE    \"%%ad\"%%n#define GIT_LAST_COMMIT_HASH    \"%%H\"%%n#define GIT_LAST_COMMIT_MESSAGE \"%%s\" %%n"
(
	git log --pretty=format:%git_log_format% -n 1
) >> build_info.h

set status_text=
set row=
for /F "tokens=*" %%x in ('git status -s') do set "row=!row! %%x"
set status_text=%status_text%%row%

(echo #define GIT_CURRENT_CHANGES		"%status_text%") 	>> build_info.h
(echo #define BUILD_CURRENT_TIME 		"%DATE%%TIME%") 	>> build_info.h
(echo #define BUILD_CURRENT_USER		"%USERNAME%") 		>> build_info.h
(echo #define BUILD_CURRENT_HOSTNAME	"%COMPUTERNAME%") 	>> build_info.h

(echo.) >> build_info.h
(echo #endif /* BUILD_INFO_H */) >> build_info.h