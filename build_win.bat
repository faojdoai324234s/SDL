@echo off
setlocal EnableDelayedExpansion

mkdir upload
mkdir upload\include\sdl
mkdir upload\Debug
mkdir upload\Release

REM Download latest sdl
git clone --branch release-3.2.x --single-branch https://github.com/libsdl-org/SDL

REM Build Debug configuration
cmake -S SDL -B build -D CMAKE_BUILD_TYPE=Debug
cmake --build build --config Debug
cmake --install build

REM Copy over the built files
copy /y /v build\Debug\*.dll upload\Debug
copy /y /v build\Debug\*.lib upload\Debug
copy /y /v build\Debug\*.pdb upload\Debug

REM Clean up before we run CMake again
rmdir /s /q build

REM Build Release configuration
cmake -S SDL -B build -D CMAKE_BUILD_TYPE=Release
cmake --build build --config Release
cmake --install build

REM Copy over the built files
copy /y /v build\Release\*.dll upload\Release
copy /y /v build\Release\*.lib upload\Release

REM Copy over the headers
xcopy /y /v /s /e SDL\include upload\include\sdl

exit /b
