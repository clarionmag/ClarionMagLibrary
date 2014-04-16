rem This file is executed in the context of the bin (output) directory
rem so all file locations need to be relative to that location
@echo off
xcopy CMagLib.dll ..\bin /D /Y
xcopy CMagLib.dll ..\UnitTests /D /Y
xcopy CMagLib.dll ..\ClarionTest /D /Y
xcopy ..\build\obj\debug\CMagLib.lib ..\lib /D /Y
xcopy ..\build\obj\release\CMagLib.lib ..\lib /D /Y