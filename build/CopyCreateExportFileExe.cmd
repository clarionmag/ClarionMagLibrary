rem This file is executed in the context of the bin (output) directory
rem so all file locations need to be relative to that location
@echo off
xcopy CreateExportFile.exe ..\bin /D /Y
