#!/bin/bash

# Prepare the build with creating the file structure
mkdir upload
mkdir upload/include
mkdir upload/include/sdl
mkdir upload/Debug
mkdir upload/Release

git clone --branch release-3.2.x --single-branch https://github.com/libsdl-org/SDL

# Build Debug configuration
cmake -S SDL -B build -D CMAKE_BUILD_TYPE=Debug -D SDL_CAMERA=OFF -D SDL_JOYSTICK=OFF -D SDL_HAPTIC=OFF -D SDL_HIDAPI=OFF -D SDL_POWER=OFF -D SDL_SENSOR=OFF -D SDL_DIALOG=OFF "-DCMAKE_OSX_ARCHITECTURES=arm64;x86_64" -D CMAKE_OSX_DEPLOYMENT_TARGET=10.11
cmake --build build --config Debug
cmake --install build

# Copy over the built files
cp build/libSDL3.dylib upload/Debug/libSDL3d.dylib
cp build/libSDL_uclibc.a upload/Debug

# Clean up before we run CMake again
rm -rf build

# Build Release configuration
cmake -S SDL -B build -D CMAKE_BUILD_TYPE=Release -D SDL_CAMERA=OFF -D SDL_JOYSTICK=OFF -D SDL_HAPTIC=OFF -D SDL_HIDAPI=OFF -D SDL_POWER=OFF -D SDL_SENSOR=OFF -D SDL_DIALOG=OFF "-DCMAKE_OSX_ARCHITECTURES=arm64;x86_64" -D CMAKE_OSX_DEPLOYMENT_TARGET=10.11
cmake --build build --config Release
cmake --install build

# Copy over the built files
cp build/libSDL3.dylib upload/Release
cp build/libSDL_uclibc.a upload/Release

# Copy over the headers
cp -r SDL/include/SDL3/. upload/include/sdl
