cmake_minimum_required(VERSION 3.23)

project(vAdd_hip)

# Find hip
find_package(hip REQUIRED)

# Create the excutable
add_executable(vAdd_hip vAdd_hip.cpp)

# Link with HIP
target_link_libraries(vAdd_hip hip::device)
