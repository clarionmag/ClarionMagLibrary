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


                                                   Member('ClarionTestRunner')

TeamCityRunner                                     procedure()

TestProceduresQ                                       queue(CML_ClarionTest_TestProceduresQueue)
                                                      end
TestResult                                            &CML_ClarionTest_TestResult
TestRunner                                            CML_ClarionTest_TestRunner
TestListLoader                                        CML_ClarionTest_ListLoader
TestDLL                                               CML_ClarionTest_TestDLL

x                                                     Long
FailedTestCount                                       long
   code
   !TeamCityLogFilename = 'teamcity-info.xml'
   !If not TeamCityLog.CreateFile(TeamCityLogFilename) = LEVEL:Benign then return end
   TestDllName = command('TestDLL')
   dbg.write('TestDLLName: ' & TestDLLName)
   StdOut.OpenCurrentConsole()
   StdOut.WriteToCurrentConsole('##teamcity[testSuiteStarted name=<39>' & TestDllName & '<39>]]'& '<13,10>')
   TestDllPathAndName = longpath() & '\' & TestDllName 
   if not exists(TestDllPathAndName)
      StdOut.WriteToCurrentConsole('##teamcity[buildProblem description=<39>Test DLL missing<39> identity=<39>' & TestDllName & '<39>]]')
      StdOut.WriteToCurrentConsole('##teamcity[testSuiteFinished name=<39>' & TestDllName & '<39>]]')
      return
   end
   if TestDll.Init(TestDllPathAndName) <> Level:Benign
      StdOut.WriteToCurrentConsole('##teamcity[buildProblem description=<39>Test DLL could not be loaded<39> identity=<39>' & TestDllName & '<39>]]')
      StdOut.WriteToCurrentConsole('##teamcity[testSuiteFinished name=<39>' & TestDllName & '<39>]]')
      return
   end      
   TestListLoader.GetTestProceduresFromDLL(TestDLL,TestProceduresQ)
   if records(TestProceduresQ) = 0
      StdOut.WriteToCurrentConsole('##teamcity[buildProblem description=<39>No tests found in test DLL<39> identity=<39>' & TestDllName & '<39>]]')
      StdOut.WriteToCurrentConsole('##teamcity[testSuiteFinished name=<39>' & TestDllName & '<39>]]')
      TestDll.Kill()
      return
   end
   dbg.write(records(TestProceduresQ) & ' tests found')
   TestRunner.SetTestProcedures(TestProceduresQ)
   loop x = 1 to records(TestProceduresQ)
      get(TestProceduresQ,x)
      dbg.Write('Test ' & TestProceduresQ.TestName)
      TestResult &= TestRunner.RunTest(TestDll,x)
      dbg.write('TestResult.Status ' & TestResult.Status & ' ' & TestResult.Message)
      case TestResult.Status
      of CML_ClarionTest_Status_Pass
         dbg.write('Test passed')
      of CML_ClarionTest_Status_Fail
         FailedTestCount += 1
         StdOut.WriteToCurrentConsole('##teamcity[testFailed name=<39>' & clip(TestProceduresQ.TestName) &|
            '<39> message=<39>' & TestResult.Message & '<39>]]'& '<13,10>')
      of CML_ClarionTest_Status_Ignore
      orof CML_ClarionTest_Status_Disabled
      of CML_ClarionTest_Status_Incomplete
      end
   end
   if FailedTestCount > 0
      StdOut.WriteToCurrentConsole(FailedTestCount & ' ##teamcity[buildProblem description=<39>One or more tests failed<39>]]')
   end 
   
   StdOut.WriteToCurrentConsole('##teamcity[testSuiteFinished name=<39>' & TestDllName & '<39>]]')
   StdOut.CloseCurrentConsole()
   TestDll.Kill()
   return
   !TeamCityLog.CloseFile()
