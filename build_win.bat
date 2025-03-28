@echo off
setlocal EnableDelayedExpansion

mkdir upload
mkdir upload\include\sdl
mkdir upload\Debug
mkdir upload\Release

REM Download latest sdl
git clone --branch release-3.2.x --single-branch https://github.com/libsdl-org/SDL

REM Build Debug configuration
cmake -S SDL -B build -D CMAKE_BUILD_TYPE=Debug -D SDL_CAMERA=OFF -D SDL_JOYSTICK=OFF -D SDL_HAPTIC=OFF -D SDL_HIDAPI=OFF -D SDL_POWER=OFF -D SDL_SENSOR=OFF -D SDL_DIALOG=OFF
cmake --build build --config Debug
cmake --install build

REM Copy over the built files
copy /y /v build\Debug\SDL3.dll upload\Debug
copy /y /v build\Debug\SDL3.lib upload\Debug\SDL3d.lib
copy /y /v build\Debug\SDL3.pdb upload\Debug

REM Clean up before we run CMake again
rmdir /s /q build

REM Build Release configuration
cmake -S SDL -B build -D CMAKE_BUILD_TYPE=Release -D SDL_CAMERA=OFF -D SDL_JOYSTICK=OFF -D SDL_HAPTIC=OFF -D SDL_HIDAPI=OFF -D SDL_POWER=OFF -D SDL_SENSOR=OFF -D SDL_DIALOG=OFF
cmake --build build --config Release
cmake --install build

REM Copy over the built files
copy /y /v build\Release\SDL3.dll upload\Release
copy /y /v build\Release\SDL3.lib upload\Release

REM Copy over the headers
xcopy /y /v /s /e SDL\include\SDL3 upload\include\sdl

exit /b
