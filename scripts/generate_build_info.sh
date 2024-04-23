#!/bin/bash

echo "#ifndef BUILD_INFO_H" > build_info.h
echo "#define BUILD_INFO_H" >> build_info.h
echo "" >> build_info.h

git_log_format="#define GIT_LAST_COMMIT_DATE    \"%ad\"%n#define GIT_LAST_COMMIT_HASH    \"%H\"%n#define GIT_LAST_COMMIT_MESSAGE \"%s\" %n"
git log --pretty=format:"${git_log_format}" -n 1 >> build_info.h

status_text=
row=
IFS=$'\n'
for row in $(git status -s)
do
	status_text="${status_text}${row}"
done

branch=$(git branch --show-current)

echo "#define GIT_CURRENT_CHANGES		\"${status_text}\"" >> build_info.h
echo "#define GIT_CURRENT_BRANCH		\"${branch}\"" >> build_info.h
echo "#define BUILD_CURRENT_TIME 		\"$(date)\"" >> build_info.h
echo "#define BUILD_CURRENT_USER		\"$(whoami)\"" >> build_info.h
echo "#define BUILD_CURRENT_HOSTNAME	\"$(hostname)\"" >> build_info.h

echo "" >> build_info.h
echo "#endif /* BUILD_INFO_H */" >> build_info.h