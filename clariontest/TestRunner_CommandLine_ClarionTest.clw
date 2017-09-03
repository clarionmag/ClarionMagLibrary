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


                     Member('ClarionTest')

TestRunner_CommandLine                                     procedure(string listName)
   code
   !   
!      ! Called as a command line utility
!      ShowUI = false
!      RunAllTests = true
!      do PrepareProcedure
!      if exists(TestDllPathAndName)
!         StdOut.Write('##teamcity[testSuiteStarted name=<39>' & TestDllName & '<39>]]')
!         do LoadTests
!         do RunTests
!         StdOut.Write('##teamcity[testSuiteFinished name=<39>' & TestDllName & '<39>]]')
!      else
!         StdOut.Write('##teamcity[testFailed message=<39>DLL not found<39> details=<39>' & TestDllPathAndName & '<39>]]')
!      end
!      !message('done')
!      return
!   end

   
   


