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


    include('CML_IncludeInAllClassHeaderFiles.inc'),once

include('CML_System_Diagnostics_Logger.inc')
!--------------------------
!ClarionLive Debug Class
!--------------------------
!--------------------------------------------------------------------------------
!Category: Clarion Live!
!--------------------------------------------------------------------------------
! Debug Class used to begin building your own classes with!
! The OMIT at the top is used to load the class only once, so you do not have to use the "once" statement when you INCLUDE the class in your global includes
!
!--------------------------------------------------------------------------------
CML_ClarionTest_SQLPlugin                        CLASS,TYPE,MODULE('CML_ClarionTest_SQLPlugin.CLW'),LINK('CML_ClarionTest_SQLPlugin.CLW')!,_CML_Classes_LinkMode_),DLL(_CML_Classes_DllMode_)
!
!--------------------------------------------------------------------------------
! Add properties here, which are variables
!--------------------------------------------------------------------------------
!Properties
!----------
InDebug                             BYTE
!
!--------------------------------------------------------------------------------
! Add Methods here, which are just procedures or functions
!--------------------------------------------------------------------------------
!Methods
!-------
      

Init                                                PROCEDURE(String pOwnerName)
Kill                                                PROCEDURE()
CML_SQLQuery                                           FUNCTION (STRING, <*QUEUE>, <*?>, <*?>, <*?>, <*?>,<*?>,<*?>, <*?>, <*?>, <*?>, <*?>, <*?>, <*?>, <*?>, <*?>, <*?>, <*?>, <*?>, <*?>,<*?>, <*?>, <*?>, <*?>, <*?>, <*?>),BYTE,proc
CML_RestoreDatabase                                    FUNCTION(STRING pDataBase,STRING pNewDataBase),BYTE,proc
CML_ExecuteScript                                       PROCEDURE(STRING pFileName),BYTE,proc
RaiseError                                          PROCEDURE(STRING pErrorMsg)
Construct                                           PROCEDURE()
Destruct                                            PROCEDURE()
												END

