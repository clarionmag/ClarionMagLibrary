!---------------------------------------------------------------------------------------------!
! Copyright (c) 2017, CoveComm Inc.
!
!Permission is hereby granted, free of charge, to any person obtaining a copy
!of this software and associated documentation files (the "Software"), to deal
!in the Software without restriction, including without limitation the rights
!to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
!copies of the Software, and to permit persons to whom the Software is
!furnished to do so, subject to the following conditions:
!
!The above copyright notice and this permission notice shall be included in all
!copies or substantial portions of the Software.
!
!THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
!IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
!FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
!AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
!LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
!OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
!SOFTWARE.
!---------------------------------------------------------------------------------------------!

                                                   PROGRAM

   include('CML_ClarionTest_TestRunner.inc'),once
   include('CML_ClarionTest_TestResult.inc'),once
   include('CML_ClarionTest_ListLoader.inc'),once
   include('CML_ClarionTest_TestDLL.inc'),once
   Include('CML_System_Runtime_DirectoryWatcher.inc'),once
   include('CML_System_Diagnostics_Logger.inc'),once
   include('CML_System_String.inc'),once
   include('CML_System_IO_Directory.inc'),once
   Include('CML_System_IO_StdOut.inc'),Once
   INCLUDE('ABUTIL.INC'),ONCE

Logger                                             CML_System_Diagnostics_Logger


                                                   MAP
                                                      Module('TestRunner_Window_ClarionTest.clw')
                                                         TestRunner_Window()
                                                      End
                                                      Module('TestRunner_CommandLine_ClarionTest.clw')
                                                         TestRunner_CommandLine(String filename)
                                                      end
                                                      Module('About_ClarionTest.clw')
                                                         About()
                                                      End
                                                      !Module('ClarionTest_Settings.clw')
                                                      !   Settings()
                                                      !End
                                                      Module('')
                                                         Sleep(long milliseconds),Pascal
                                                      End
                                                   End

Settings                                           INIClass                               ! Global non-volatile storage manager
dbg                                                CML_System_Diagnostics_Logger
ProgramDirectory                                   cstring(File:MaxFilePath + 1)
TestDllDirectory                                   cstring(File:MaxFilePath + 1)
TestDllName                                        cstring(FILE:MaxFileName + 1)
TestListFilename                                   cstring(100)

   CODE
   Settings.Init(LongPath() & '\ClarionTest.INI', NVD_INI)  ! Configure INIManager to use INI file
   ProgramDirectory = longpath()
   TestListFilename = command('TestListFile')
   if TestListFilename <> ''
      TestRunner_CommandLine(TestListFilename)
   else
      TestRunner_Window()
   end
   Settings.Kill                                            ! Destroy INI manager
