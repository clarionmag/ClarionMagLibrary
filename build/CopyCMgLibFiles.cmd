rem This file is executed in the context of the bin (output) directory
rem so all file locations need to be relative to that location
@echo off
xcopy CMgLib.dll ..\bin /D /Y
xcopy CMgLib.dll ..\UnitTests /D /Y
xcopy CMgLib.dll ..\ClarionTest /D /Y
xcopy ..\build\obj\debug\CMgLib.lib ..\lib /D /Y
xcopy ..\build\obj\release\CMgLib.lib ..\lib /D /Y