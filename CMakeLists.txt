# == DO NEVER EDIT THE NEXT LINES for Raspberry Pi Pico VS Code Extension to work ==
if(WIN32)
    set(USERHOME $ENV{USERPROFILE})
else()
    set(USERHOME $ENV{HOME})
endif()
set(sdkVersion 2.0.0)
set(toolchainVersion 13_2_Rel1)
set(picotoolVersion 2.0.0)
if (DEFINED PICO_SDK_PATH)
# Already defined, e.g. -D flag
elseif (DEFINED ENV{PICO_SDK_PATH})
# Defined in an environment variable
    set(PICO_SDK_PATH $ENV{PICO_SDK_PATH})
else()
# Use the submodule
    set(PICO_SDK_PATH lib/pico-sdk)
endif()

if (DEFINED FREERTOS_PATH)
# Already defined, e.g. -D flag
elseif(DEFINED ENV{FREERTOS_PATH})
# Defined in an environment variable
    set(FREERTOS_PATH $ENV{FREERTOS_PATH})
else()
# Default use the submodule.
    set(FREERTOS_PATH lib/freertos)
endif()
if (DEFINED UNITY_PATH)
# Already defined, e.g. -D flag
elseif(DEFINED ENV{UNITY_PATH})
# Defined in an environment variable
    set(UNITY_PATH $ENV{UNITY_PATH})
else()
# Default to the submodule
    set(UNITY_PATH lib/unity)
endif()

if(DEFINED ENV{OPENOCD_PATH})
    set(OPENOCD_PATH $ENV{OPENOCD_PATH})
endif()

# ====================================================================================
cmake_minimum_required(VERSION 3.13)

set(CMAKE_C_STANDARD 11)
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

# This sets the variant of the board. We are using the pico_w
set(PICO_BOARD pico_w CACHE STRING "Board type")

# This imports the Pico SDK (must be included before the project)
include(${PICO_SDK_PATH}/pico_sdk_init.cmake)

# This imports the library configuration for FreeRTOS
include(${FREERTOS_PATH}/portable/ThirdParty/GCC/RP2040/FreeRTOS_Kernel_import.cmake)

# This sets up the unity library. They don't provide a library export, so it's defined locally.
include(unity.cmake)

# This defines your project name, you can name it anything you want.
project(myproject C CXX ASM)

# These are some macros from the pico SDK that do some setup.
pico_sdk_init()

# This sets a preprocessor value for use in our code.
add_compile_definitions(
    configNUMBER_OF_CORES=1
    PICO_ENTER_USB_BOOT_ON_EXIT=1
    )

# This is where your project header files are located.
include_directories(${CMAKE_CURRENT_LIST_DIR}/include)

# The main executable is defined inside the src directory.
add_subdirectory(src)

# The test configuration is inside the test directory.
include(CTest)
add_subdirectory(test)
