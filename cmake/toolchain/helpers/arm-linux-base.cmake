####
# ARM Linux Toolchain Base:
#
# This file provides the basic work for ARM toolchains running on Linux systems. It uses the ARM_TOOL_PREFIX variable to
# determine the names of the tools to search for. This variable must be set in the calling script. This toolchain will
# find the ARM tools under the path  specified with -DARM_TOOLS_PATH=... and if -DCMAKE_SYSROOT=... is specified then
# this path will be used for searching for libraries/headers to compile against.
####
# Set the system information
set(CMAKE_SYSTEM_NAME       Linux)
set(CMAKE_SYSTEM_VERSION    0.1)

set(FIND_PROGRAM_INPUTS PATHS "${ARM_TOOLS_PATH}" PATH_SUFFIXES bin REQUIRED)
# Set the GNU ARM toolchain
find_program(CMAKE_ASM_COMPILER NAMES ${ARM_TOOL_PREFIX}-as ${FIND_PROGRAM_INPUTS})
find_program(CMAKE_C_COMPILER NAMES ${ARM_TOOL_PREFIX}-gcc ${FIND_PROGRAM_INPUTS})
find_program(CMAKE_CXX_COMPILER NAMES ${ARM_TOOL_PREFIX}-g++ ${FIND_PROGRAM_INPUTS})
find_program(CMAKE_AR NAMES ${ARM_TOOL_PREFIX}-ar ${FIND_PROGRAM_INPUTS})
find_program(CMAKE_OBJCOPY NAMES ${ARM_TOOL_PREFIX}-objcopy ${FIND_PROGRAM_INPUTS})
find_program(CMAKE_OBJDUMP NAMES ${ARM_TOOL_PREFIX}-objdump ${FIND_PROGRAM_INPUTS})
message(STATUS "[arm-linux] C Compiler: ${CMAKE_C_COMPILER}")
message(STATUS "[arm-linux] CXX Compiler: ${CMAKE_CXX_COMPILER}")

# Force sysroot onto
if (DEFINED CMAKE_SYSROOT)
    message(STATUS "sysroot set to: ${CMAKE_SYSROOT}")
    set(CMAKE_FIND_ROOT_PATH ${CMAKE_FIND_ROOT_PATH} "${CMAKE_SYSROOT}")
endif()

# Configure the find commands for finding the toolchain
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE ONLY)
