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



   !include('CML_IncludeInAllClassHeaderFiles.inc'),once


CML_ClarionTest_UnitTestTypes                      Itemize,pre()
IsEqualTo                                             equate(1)
IsNotEqualTo                                          equate
                                                   end
CML_ClarionTest_UnitTestVariableTypes              Itemize,pre()
StringType                                            equate
IntegerType                                           equate
                                                   end


CML_ClarionTest_TestResult              CLASS,type
ProcedureName                               cstring(100)
Description                                 cstring(1000)
Status                                      long
Message                                     cstring(1000)
IsDisabled                                            bool
IsIncomplete                                          bool

										END
!GlobalTestResultInstance	CML_ClarionTest_TestResult

CML_ClarionTest_Status_Pass                        equate(1)
CML_ClarionTest_Status_Fail                        equate(2)
CML_ClarionTest_Status_Ignore                      equate(3)
CML_ClarionTest_Status_Disabled                    equate(3) ! Synonym for Ignore
CML_ClarionTest_Status_Incomplete                  equate(4)





