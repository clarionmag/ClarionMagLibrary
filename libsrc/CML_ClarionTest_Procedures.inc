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
	!include('CML_System_ErrorManager.inc'),once

CML_ClarionTest_TestProceduresQueue         queue,TYPE
TestGroup                                   string(200)
TestGroupStyle                              long
Priority                                    decimal(6,2)
PriorityStyle                               long
TestName                                    string(200)
TestNameStyle                               LONG
TestResult                                  string(400)
TestResultStyle                             LONG
Passed                                      BYTE(false)
PassedStyle                                 LONG
Mark                                        BYTE
TestGroupOrder                              LONG(0)
										end


CML_ClarionTest_TestProcedures              Class,Type,Module('CML_ClarionTest_TestProcedures.CLW'),Link('CML_ClarionTest_TestProcedures.CLW',_CML_Classes_LinkMode_),Dll(_CML_Classes_DllMode_)
DllName                                               cstring(500)
List                                        &CML_ClarionTest_TestProceduresQueue
Construct                                   PROCEDURE
Destruct                                    procedure
										end


