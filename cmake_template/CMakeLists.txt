# Minimum required version of CMake
cmake_minimum_required(VERSION x.xx)

# Project name and version
project(MyProject VERSION x.x.x)

# Set the C++ standard
set(CMAKE_CXX_STANDARD xx)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

# Options (useful for enabling/disabling features)
option(BUILD_SHARED_LIBS "Build shared libraries instead of static" ON)

# Specify output directories for binaries and libraries
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)

# Include directories
include_directories(${PROJECT_SOURCE_DIR}/include)

# Collect all source files
file(GLOB_RECURSE SOURCES
    ${PROJECT_SOURCE_DIR}/src/*.cpp
)

# Add executable or library target
add_executable(${PROJECT_NAME} ${SOURCES})

# Add libraries if needed
# target_link_libraries(${PROJECT_NAME} PRIVATE SomeLibrary)

# Installation rules
install(TARGETS ${PROJECT_NAME}
    RUNTIME DESTINATION bin
    LIBRARY DESTINATION lib
    ARCHIVE DESTINATION lib
)

# Testing setup (optional)
enable_testing()
add_test(NAME ExampleTest COMMAND ${PROJECT_NAME})
