#!/bin/bash

# Prepare the build with creating the file structure
mkdir upload
mkdir upload/include
mkdir upload/include/sdl
mkdir upload/Debug
mkdir upload/Release

git clone --branch release-3.2.x --single-branch https://github.com/libsdl-org/SDL

# Install dependencies
# sudo apt-get update && sudo apt-get install libaudio-dev libasound2-dev libglew-dev libjack-dev libpipewire-0.3 libpulse-dev libwayland-client libwayland-dev libx11-dev
sudo apt-get update && sudo apt-get install build-essential \
pkg-config gnome-desktop-testing libasound2-dev libpulse-dev \
libaudio-dev libjack-dev libsndio-dev libx11-dev libxext-dev \
libxrandr-dev libxcursor-dev libxfixes-dev libxi-dev libxss-dev libxtst-dev \
libxkbcommon-dev libdrm-dev libgbm-dev libgl1-mesa-dev libgles2-mesa-dev \
libegl1-mesa-dev libdbus-1-dev libibus-1.0-dev libudev-dev libpipewire-0.3-dev libwayland-dev libdecor-0-dev liburing-dev

# Build Debug configuration
cmake -S SDL -B build -D CMAKE_BUILD_TYPE=Debug -D SDL_CAMERA=OFF -D SDL_JOYSTICK=OFF -D SDL_HAPTIC=OFF -D SDL_HIDAPI=OFF -D SDL_POWER=OFF -D SDL_SENSOR=OFF -D SDL_DIALOG=OFF
cmake --build build --config Debug
cmake --install build

# Copy over the built files
cp build/libSDL3.so upload/Debug/libSDL3d.so
cp build/libSDL_uclibc.a upload/Debug

# Clean up before we run CMake again
rm -rf build

# Build Release configuration
cmake -S SDL -B build -D CMAKE_BUILD_TYPE=Release -D SDL_CAMERA=OFF -D SDL_JOYSTICK=OFF -D SDL_HAPTIC=OFF -D SDL_HIDAPI=OFF -D SDL_POWER=OFF -D SDL_SENSOR=OFF -D SDL_DIALOG=OFF
cmake --build build --config Release
cmake --install build

# Copy over the built files
cp build/libSDL3.so upload/Release
cp build/libSDL_uclibc.a upload/Release

# Copy over the headers
cp -r SDL/include/SDL3/. upload/include/sdl
