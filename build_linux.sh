#!/bin/bash

# Prepare the build with creating the file structure
mkdir upload
mkdir upload/include
mkdir upload/include/sdl
mkdir upload/Debug
mkdir upload/Release

git clone --branch release-3.2.x --single-branch https://github.com/libsdl-org/SDL

# Install dependencies
sudo apt-get update && sudo apt-get install libglew-dev alsa-base

# Build Debug configuration
cmake -S SDL -B build -D CMAKE_BUILD_TYPE=Debug -D SDL_CAMERA=OFF -D SDL_JOYSTICK=OFF -D SDL_HAPTIC=OFF -D SDL_HIDAPI=OFF -D SDL_POWER=OFF -D SDL_SENSOR=OFF -D SDL_DIALOG=OFF
cmake --build build --config Debug
cmake --install build

# Copy over the built files
cp build/SDL3.so upload/Debug/SDL3d.so

# Clean up before we run CMake again
rm -rf build

# Build Release configuration
cmake -S SDL -B build -D CMAKE_BUILD_TYPE=Release -D SDL_CAMERA=OFF -D SDL_JOYSTICK=OFF -D SDL_HAPTIC=OFF -D SDL_HIDAPI=OFF -D SDL_POWER=OFF -D SDL_SENSOR=OFF -D SDL_DIALOG=OFF
cmake --build build --config Release
cmake --install build

# Copy over the built files
cp build/SDL3.so upload/Release

# Copy over the headers
cp -r SDL/include/SDL3/. upload/include/sdl
