
if(NOT "D:/Programming/c++/skillbox/cmake-build-debug/_deps/json-subbuild/json-populate-prefix/src/json-populate-stamp/json-populate-gitinfo.txt" IS_NEWER_THAN "D:/Programming/c++/skillbox/cmake-build-debug/_deps/json-subbuild/json-populate-prefix/src/json-populate-stamp/json-populate-gitclone-lastrun.txt")
  message(STATUS "Avoiding repeated git clone, stamp file is up to date: 'D:/Programming/c++/skillbox/cmake-build-debug/_deps/json-subbuild/json-populate-prefix/src/json-populate-stamp/json-populate-gitclone-lastrun.txt'")
  return()
endif()

execute_process(
  COMMAND ${CMAKE_COMMAND} -E rm -rf "D:/Programming/c++/skillbox/cmake-build-debug/_deps/json-src"
  RESULT_VARIABLE error_code
  )
if(error_code)
  message(FATAL_ERROR "Failed to remove directory: 'D:/Programming/c++/skillbox/cmake-build-debug/_deps/json-src'")
endif()

# try the clone 3 times in case there is an odd git clone issue
set(error_code 1)
set(number_of_tries 0)
while(error_code AND number_of_tries LESS 3)
  execute_process(
    COMMAND "C:/Program Files/Git/cmd/git.exe"  clone --no-checkout --config "advice.detachedHead=false" "https://github.com/nlohmann/json.git" "json-src"
    WORKING_DIRECTORY "D:/Programming/c++/skillbox/cmake-build-debug/_deps"
    RESULT_VARIABLE error_code
    )
  math(EXPR number_of_tries "${number_of_tries} + 1")
endwhile()
if(number_of_tries GREATER 1)
  message(STATUS "Had to git clone more than once:
          ${number_of_tries} times.")
endif()
if(error_code)
  message(FATAL_ERROR "Failed to clone repository: 'https://github.com/nlohmann/json.git'")
endif()

execute_process(
  COMMAND "C:/Program Files/Git/cmd/git.exe"  checkout v3.7.3 --
  WORKING_DIRECTORY "D:/Programming/c++/skillbox/cmake-build-debug/_deps/json-src"
  RESULT_VARIABLE error_code
  )
if(error_code)
  message(FATAL_ERROR "Failed to checkout tag: 'v3.7.3'")
endif()

set(init_submodules TRUE)
if(init_submodules)
  execute_process(
    COMMAND "C:/Program Files/Git/cmd/git.exe"  submodule update --recursive --init 
    WORKING_DIRECTORY "D:/Programming/c++/skillbox/cmake-build-debug/_deps/json-src"
    RESULT_VARIABLE error_code
    )
endif()
if(error_code)
  message(FATAL_ERROR "Failed to update submodules in: 'D:/Programming/c++/skillbox/cmake-build-debug/_deps/json-src'")
endif()

# Complete success, update the script-last-run stamp file:
#
execute_process(
  COMMAND ${CMAKE_COMMAND} -E copy
    "D:/Programming/c++/skillbox/cmake-build-debug/_deps/json-subbuild/json-populate-prefix/src/json-populate-stamp/json-populate-gitinfo.txt"
    "D:/Programming/c++/skillbox/cmake-build-debug/_deps/json-subbuild/json-populate-prefix/src/json-populate-stamp/json-populate-gitclone-lastrun.txt"
  RESULT_VARIABLE error_code
  )
if(error_code)
  message(FATAL_ERROR "Failed to copy script-last-run stamp file: 'D:/Programming/c++/skillbox/cmake-build-debug/_deps/json-subbuild/json-populate-prefix/src/json-populate-stamp/json-populate-gitclone-lastrun.txt'")
endif()

