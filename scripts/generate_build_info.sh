#!/bin/bash

# Retrieve the current Git and build status and store it into single line strings.
GIT_LAST_COMMIT_DATE=$(git log --pretty=format:%ad -n 1)
GIT_LAST_COMMIT_HASH=$(git log --pretty=format:%H -n 1)
GIT_LAST_COMMIT_MESSAGE=$(git log --pretty=format:%s -n 1)
GIT_CURRENT_CHANGES=$(git status -s)
GIT_CURRENT_BRANCH=$(git branch --show-current)

BUILD_CURRENT_TIME=$(date)
BUILD_CURRENT_USER=$(whoami)
BUILD_CURRENT_HOSTNAME=$(hostname)


# Process the strings to remove any characters that might break a C string.
GIT_LAST_COMMIT_DATE=${GIT_LAST_COMMIT_DATE//[$'\n']/ }
GIT_LAST_COMMIT_DATE=${GIT_LAST_COMMIT_DATE//[\"]/}
GIT_LAST_COMMIT_DATE=${GIT_LAST_COMMIT_DATE//[\\]//}

GIT_LAST_COMMIT_HASH=${GIT_LAST_COMMIT_HASH//[$'\n']/ }
GIT_LAST_COMMIT_HASH=${GIT_LAST_COMMIT_HASH//[\"]/}
GIT_LAST_COMMIT_HASH=${GIT_LAST_COMMIT_HASH//[\\]//}

GIT_LAST_COMMIT_MESSAGE=${GIT_LAST_COMMIT_MESSAGE//[$'\n']/ }
GIT_LAST_COMMIT_MESSAGE=${GIT_LAST_COMMIT_MESSAGE//[\"]/}
GIT_LAST_COMMIT_MESSAGE=${GIT_LAST_COMMIT_MESSAGE//[\\]//}

GIT_CURRENT_CHANGES=${GIT_CURRENT_CHANGES//[$'\n']/ }
GIT_CURRENT_CHANGES=${GIT_CURRENT_CHANGES//[\"]/}
GIT_CURRENT_CHANGES=${GIT_CURRENT_CHANGES//[\\]//}

GIT_CURRENT_BRANCH=${GIT_CURRENT_BRANCH//[$'\n']/ }
GIT_CURRENT_BRANCH=${GIT_CURRENT_BRANCH//[\"]/}
GIT_CURRENT_BRANCH=${GIT_CURRENT_BRANCH//[\\]//}

BUILD_CURRENT_TIME=${BUILD_CURRENT_TIME//[$'\n']/ }
BUILD_CURRENT_TIME=${BUILD_CURRENT_TIME//[\"]/}
BUILD_CURRENT_TIME=${BUILD_CURRENT_TIME//[\\]//}

BUILD_CURRENT_USER=${BUILD_CURRENT_USER//[$'\n']/ }
BUILD_CURRENT_USER=${BUILD_CURRENT_USER//[\"]/}
BUILD_CURRENT_USER=${BUILD_CURRENT_USER//[\\]//}

BUILD_CURRENT_HOSTNAME=${BUILD_CURRENT_HOSTNAME//[$'\n']/ }
BUILD_CURRENT_HOSTNAME=${BUILD_CURRENT_HOSTNAME//[\"]/}
BUILD_CURRENT_HOSTNAME=${BUILD_CURRENT_HOSTNAME//[\\]//}


# Write the strings to the output file.
echo "#ifndef BUILD_INFO_H" > build_info.h
echo "#define BUILD_INFO_H" >> build_info.h
echo "" >> build_info.h

echo "#define GIT_LAST_COMMIT_DATE         \"${GIT_LAST_COMMIT_DATE}\""        >> build_info.h
echo "#define GIT_LAST_COMMIT_HASH         \"${GIT_LAST_COMMIT_HASH}\""        >> build_info.h
echo "#define GIT_LAST_COMMIT_MESSAGE      \"${GIT_LAST_COMMIT_MESSAGE}\""     >> build_info.h
echo "#define GIT_CURRENT_CHANGES          \"${GIT_CURRENT_CHANGES}\""         >> build_info.h
echo "#define GIT_CURRENT_BRANCH           \"${GIT_CURRENT_BRANCH}\""          >> build_info.h
echo "#define BUILD_CURRENT_TIME           \"${BUILD_CURRENT_TIME}\""          >> build_info.h
echo "#define BUILD_CURRENT_USER           \"${BUILD_CURRENT_USER}\""          >> build_info.h
echo "#define BUILD_CURRENT_HOSTNAME       \"${BUILD_CURRENT_HOSTNAME}\""      >> build_info.h

echo "" >> build_info.h
echo "#endif /* BUILD_INFO_H */" >> build_info.h